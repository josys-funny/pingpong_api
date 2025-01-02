class CreateMatchUserTable < ActiveRecord::Migration[8.0]
  def change
    create_table :match_users do |t|
      t.references :user, foreign_key: { to_table: :users }
      t.references :match, foreign_key: { to_table: :matches }
      t.integer :team, default: 0 # 0: first team, 1: second team
      t.timestamps
    end
  end
end
