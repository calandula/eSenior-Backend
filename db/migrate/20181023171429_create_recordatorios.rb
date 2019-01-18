class CreateRecordatorios < ActiveRecord::Migration[5.2]
  def change
    create_table :recordatorios do |t|
      t.date :data
      t.text :texto
      t.integer :user_id

      t.timestamps
    end
  end
end
