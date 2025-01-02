class AddBestOfColumnToMatch < ActiveRecord::Migration[8.0]
  def up
    add_column :matches, :best_of, :integer, default: 1
  end

  def down
    remove_column :matches, :best_of
  end
end
