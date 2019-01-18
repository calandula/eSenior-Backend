class AddFilasColumnasToTableros < ActiveRecord::Migration[5.2]
  def change
    add_column :tableros, :filas, :integer
    add_column :tableros, :columnas, :integer
  end
end
