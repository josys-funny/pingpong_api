class ChangeColumnNameOfMatchUsers < ActiveRecord::Migration[8.0]
  def up
    rename_column :match_users, :team, :team_side
  end

  def down
    rename_column :match_users, :team_side, :team
  end
end
