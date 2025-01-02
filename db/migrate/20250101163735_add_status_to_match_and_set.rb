class AddStatusToMatchAndSet < ActiveRecord::Migration[8.0]
  def up
    add_column :matches, :status, :integer, default: 0
    add_column :match_sets, :status, :integer, default: 0
  end

  def down
    remove_column :matches, :status
    remove_column :match_sets, :status
  end
end
