class AddQuedadasToTablero < ActiveRecord::Migration[5.2]
  def change
    add_column :tableros, :quedada_id, :integer
  end
end
