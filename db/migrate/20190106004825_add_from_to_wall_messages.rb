class AddFromToWallMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :wall_messages, :from, :integer
  end
end
