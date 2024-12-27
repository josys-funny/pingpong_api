class CreateMatchUserTable < ActiveRecord::Migration[8.0]
  def change
    create_table :match_user_tables do |t|
      t.references :user, foreign_key: { to_table: :users }
      t.references :match_history, foreign_key: { to_table: :match_histories }
      t.integer :team # 0: first team, 1: second team
      t.timestamps
    end
  end
end
