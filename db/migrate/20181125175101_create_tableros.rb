class CreateTableros < ActiveRecord::Migration[5.2]
  def change
    create_table :tableros do |t|
      t.text :casillas
      t.integer :user_id

      t.timestamps
    end
  end
end
