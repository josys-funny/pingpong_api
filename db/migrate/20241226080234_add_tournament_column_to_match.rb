class AddTournamentColumnToMatch < ActiveRecord::Migration[8.0]
  def up
    add_reference :matches, :tournament, foreign_key: { to_table: :tournaments }
  end

  def down
    remove_reference :matches, :tournament, foreign_key: { to_table: :tournaments }
  end
end
