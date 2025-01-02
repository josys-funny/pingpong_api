class AddDefaultValueForMatches < ActiveRecord::Migration[8.0]
  def up
    change_column_default :matches, :elo_change, from: nil, to: 0
    change_column_default :matches, :winner, from: nil, to: 0
    change_column_default :matches, :first_team_score, from: nil, to: 0
    change_column_default :matches, :second_team_score, from: nil, to: 0
    change_column_default :matches, :best_of, from: nil, to: 1
    change_column_default :matches, :type, from: nil, to: 0
  end

  def down
    change_column_default :matches, :elo_change, from: 0, to: nil
    change_column_default :matches, :winner, from: 0, to: nil
    change_column_default :matches, :first_team_score, from: 0, to: nil
    change_column_default :matches, :second_team_score, from: 0, to: nil
    change_column_default :matches, :best_of, from: 1, to: nil
    change_column_default :matches, :type, from: 0, to: nil
  end
end
