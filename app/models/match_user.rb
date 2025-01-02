# frozen_string_literal: true

class MatchUser < ApplicationRecord
  belongs_to :user
  belongs_to :match

  validates :user_id, presence: true
  enum :team_side, { first_side: 0, second_side: 1 }

  before_validation :set_elo, on: :create

  private

  def set_elo
    self.elo = user.elo
  end
end
