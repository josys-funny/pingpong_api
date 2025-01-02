# frozen_string_literal: true

class Match < ApplicationRecord
  has_many :match_users, dependent: :destroy
  has_many :users, through: :match_users
  has_many :match_sets, dependent: :destroy

  accepts_nested_attributes_for :match_sets, allow_destroy: true
  accepts_nested_attributes_for :match_users, allow_destroy: true

  enum :match_type, { single: 0, double: 1 }
  enum :winner, { first_side: 0, second_side: 1 }
  enum :status, { pending: 0, completed: 1 }

  validates :winner, :match_type, :elo_change, :match_sets, presence: true
  validates :elo_change, numericality: { greater_than_or_equal_to: 0 }
  validates :match_sets, length: { is: :best_of }
  validate :validate_match_users

  before_validation :set_best_of, on: %i[create]
  before_validation :set_winner, on: %i[create update]
  before_validation :set_elo_change, on: %i[create update]
  before_validation :set_match_type, on: %i[create]

  after_save :update_user_data, if: :completed?

  private

  def update_user_data
    match_users.each do |match_user|
      user = match_user.user
      user.total_match += 1
      user.total_win_match += 1 if match_user.team_side == winner.to_s
      user.elo = user.elo + elo_change * (match_user.team_side == winner.to_s ? 1 : -1)
      user.save!
    end
  end

  def set_best_of
    self.best_of = match_sets.size if match_sets.present?
    return unless best_of.even?

    errors.add(:best_of, 'must be an odd number')
    throw(:abort)
  end

  def set_winner
    return unless match_sets.present? && match_sets.all?(&:completed?)

    first_team_wins = match_sets.count(&:first_team_wins?)
    second_team_wins = match_sets.size - first_team_wins

    self.first_team_score = first_team_wins
    self.second_team_score = second_team_wins
    self.winner = first_team_wins > second_team_wins ? :first_side : :second_side
  end

  def set_elo_change
    return if winner.blank?

    # Average elo of the winning team
    winners = match_users.select { |match_user| match_user.team_side == winner.to_s }
    winner_elo = winners.sum { |match_user| match_user.user.elo } / Float(winners.size)

    # Average elo of the losing team
    losers = match_users.reject { |match_user| match_user.team_side == winner.to_s }
    loser_elo = losers.sum { |match_user| match_user.user.elo } / Float(losers.size)

    self.elo_change = calculate_elo_rating(winner_elo, loser_elo)
  end

  def set_match_type
    self.match_type = match_users.size == 2 ? :single : :double
  end

  def validate_match_users
    return errors.add(:match_users, 'users in each team must be equal') if match_users.count(&:first_side?) != match_users.count(&:second_side?)
    return errors.add(:match_users, 'must not have duplicate users') if match_users.map(&:user_id).uniq.size != match_users.size

    errors.add(:match_users, 'must have 2 or 4 users') if match_users.size != 2 && match_users.size != 4
  end

  def calculate_elo_rating(winner, loser)
    # Elo rating formula
    # https://en.wikipedia.org/wiki/Elo_rating_system
    # K = 32
    k = 32
    expected = 1.0 / (1.0 + 10.0**((loser - winner) / 400.0))
    Integer(k * (1.0 - expected))
  end
end
