class AddStyleToUser < ActiveRecord::Migration[8.0]
  def up
    add_column :users, :style, :integer, default: 0 # 0: right, 1: left
  end

  def down
    remove_column :users, :style
  end
end
