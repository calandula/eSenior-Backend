class DropWallMessages < ActiveRecord::Migration[5.2]
  def change
    drop_table :wall_messages
  end
end
