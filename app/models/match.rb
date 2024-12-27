# frozen_string_literal: true

class Match < ApplicationRecord
  has_many :match_users, dependent: :destroy
  has_many :users, through: :match_user
end
