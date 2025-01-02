class CreateSetTable < ActiveRecord::Migration[8.0]
  def change
    create_table :match_sets do |t|
      t.references :match, foreign_key: { to_table: :matches }
      t.integer :winner, default: 0 # 0: first team, 1: second team
      t.integer :first_team_score, default: 0
      t.integer :second_team_score, default: 0
      t.timestamps
    end
  end
end
