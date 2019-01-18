class AddUseridcreadorQuedadas < ActiveRecord::Migration[5.2]
  def change
    add_column :quedadas, :propetario_id, :integer
  end
end
