class RemoveUseridFromTableros < ActiveRecord::Migration[5.2]
  def change
    remove_column :tableros, :user_id, :integer
  end
end
