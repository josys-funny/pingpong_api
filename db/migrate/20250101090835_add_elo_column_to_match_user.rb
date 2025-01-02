class AddEloColumnToMatchUser < ActiveRecord::Migration[8.0]
  def up
    add_column :match_users, :elo, :integer, null: false, default: 1000
  end

  def down
    remove_column :match_users, :elo
  end
end
