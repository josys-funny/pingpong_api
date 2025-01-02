# frozen_string_literal: true

class MatchSet < ApplicationRecord
  belongs_to :match

  validates :first_team_score, :second_team_score, presence: true
  validates :first_team_score, :second_team_score, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  before_validation :set_status, on: %i[create update]
  before_validation :set_winner, on: %i[create update]

  enum :winner, { first_side: 0, second_side: 1 }
  enum :status, { pending: 0, completed: 1 }

  def first_team_wins?
    first_team_score > second_team_score
  end

  def second_team_wins?
    second_team_score > first_team_score
  end

  private

  def set_status
    self.status = score_valid? ? :completed : :pending
  end

  def set_winner
    return unless score_valid?

    self.winner = first_team_score > second_team_score ? :first_side : :second_side
  end

  def score_valid?
    greater = first_team_score > second_team_score ? first_team_score : second_team_score
    lesser = first_team_score < second_team_score ? first_team_score : second_team_score

    if greater < 11
      false
    elsif greater == 11
      lesser < 10
    else
      greater - lesser == 2
    end
  end
end
