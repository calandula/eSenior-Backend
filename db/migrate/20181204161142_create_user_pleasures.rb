class CreateUserPleasures < ActiveRecord::Migration[5.2]
  def change
    create_table :user_pleasures do |t|
      t.bigint :idUser
      t.bigint :idPleasure

      t.timestamps
    end
  end
end
