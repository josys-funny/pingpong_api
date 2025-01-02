class AddDefaultValueForMatchUsers < ActiveRecord::Migration[8.0]
  def up
    change_column_default :match_users, :team, from: nil, to: 0
  end

  def down
    change_column_default :match_users, :team, from: 0, to: nil
  end
end
