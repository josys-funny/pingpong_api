class CreateMatchTable < ActiveRecord::Migration[8.0]
  def change
    create_table :matches do |t|
      t.integer :winner, default: 0 # 0: first team, 1: second team
      t.integer :type, default: 0 # 0: single, 1: double
      t.integer :first_team_score
      t.integer :second_team_score
      t.integer :elo_change
      t.timestamps
    end
  end
end
