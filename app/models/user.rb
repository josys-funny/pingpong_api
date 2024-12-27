# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, uniqueness: true
  after_initialize :set_default_values

  has_many :match_users, dependent: :destroy
  has_many :matches, through: :match_users

  enum :style, { right_hand: 0, left_hand: 1 }

  private

  def set_default_values
    self.elo ||= 1200
    self.win_streak ||= 0
    self.total_match ||= 0
    self.total_win_match ||= 0
    self.team ||= 'Default'
  end
end
