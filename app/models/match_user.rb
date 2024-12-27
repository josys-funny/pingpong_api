# frozen_string_literal: true

class MatchUser < ApplicationRecord
  belongs_to :user
  belongs_to :match

  validates :user_id, :match_id, presence: true
end
