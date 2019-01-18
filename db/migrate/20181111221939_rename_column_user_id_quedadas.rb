class RenameColumnUserIdQuedadas < ActiveRecord::Migration[5.2]
  def change
    rename_column :quedadas, :propetario_id, :user_id
  end
end
