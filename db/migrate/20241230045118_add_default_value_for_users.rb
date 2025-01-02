class AddDefaultValueForUsers < ActiveRecord::Migration[8.0]
  def up
    change_column_default :users, :elo, from: nil, to: 1200
    change_column_default :users, :win_streak, from: nil, to: 0
    change_column_default :users, :total_match, from: nil, to: 0
    change_column_default :users, :total_win_match, from: nil, to: 0
    change_column_default :users, :team, from: nil, to: 'Josys'
  end

  def down
    change_column_default :users, :elo, from: 1000, to: nil
    change_column_default :users, :win_streak, from: 0, to: nil
    change_column_default :users, :total_match, from: 0, to: nil
    change_column_default :users, :total_win_match, from: 0, to: nil
    change_column_default :users, :team, from: 'Josys', to: nil
  end
end
