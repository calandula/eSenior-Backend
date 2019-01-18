class RenameUserPleasures < ActiveRecord::Migration[5.2]
  def change
    rename_column :user_pleasures, :idUser, :user_id
    rename_column :user_pleasures, :idPleasure, :pleasure_id
  end
end
