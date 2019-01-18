class CreatePleasures < ActiveRecord::Migration[5.2]
  def change
    create_table :pleasures do |t|
      t.string :title

      t.timestamps
    end
  end
end
