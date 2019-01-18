class DropTableros < ActiveRecord::Migration[5.2]
  def change
    drop_table :tableros
  end
end
