class CreateUserTable < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :elo, :default => 1200
      t.integer :win_streak, :default => 0
      t.integer :total_match, :default => 0
      t.integer :total_win_match, :default => 0
      t.string :team, :null => false

      t.timestamps
    end

    add_index :users, :name, unique: true
  end
end
