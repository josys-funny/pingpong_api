# frozen_string_literal: true

class Match < ApplicationRecord
  has_many :users, through: :match_users
end
