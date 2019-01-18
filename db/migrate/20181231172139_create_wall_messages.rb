class CreateWallMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :wall_messages do |t|
      t.text :texto
      t.integer :user_id

      t.timestamps
    end
  end
end
