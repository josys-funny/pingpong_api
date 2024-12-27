class CreateMatchHistories < ActiveRecord::Migration[8.0]
  def change
    create_table :match_histories do |t|
      t.integer :winner # 0: first team, 1: second team
      t.integer :type # 0: single, 1: double
      t.integer :first_team_score
      t.integer :second_team_score
      t.integer :elo_change
      t.integer :status # 0: ongoing, 1: finished
      t.timestamps
    end
  end
end
