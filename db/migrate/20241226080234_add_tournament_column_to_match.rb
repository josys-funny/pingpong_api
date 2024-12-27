class AddTournamentColumnToMatch < ActiveRecord::Migration[8.0]
  def up
    add_reference :matches, :tournament_table, foreign_key: { to_table: :tournament_tables }
  end

  def down
    remove_reference :matches, :tournament_table, foreign_key: { to_table: :tournament_tables }
  end
end
