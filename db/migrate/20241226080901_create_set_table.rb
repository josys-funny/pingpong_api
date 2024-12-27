class CreateSetTable < ActiveRecord::Migration[8.0]
  def change
    create_table :set_tables do |t|
      t.references :match_history, foreign_key: { to_table: :match_histories }
      t.integer :winner # 0: first team, 1: second team
      t.integer :first_team_score
      t.integer :second_team_score
      t.timestamps
    end
  end
end
