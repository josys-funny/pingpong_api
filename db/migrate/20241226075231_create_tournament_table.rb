class CreateTournamentTable < ActiveRecord::Migration[8.0]
  def change
    create_table :tournaments do |t|
      t.string :name
      t.integer :format, default: 0 # 0: league, 1: knockout, 2: double elimination, 3: swiss
      t.timestamps
    end
  end
end
