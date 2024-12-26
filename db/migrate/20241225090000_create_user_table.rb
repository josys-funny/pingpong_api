class CreateUserTable < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :elo
      t.integer :win_streak
      t.integer :total_match
      t.integer :total_win_match
      t.string :team

      t.timestamps
    end

    add_index :users, :name, unique: true
  end
end
