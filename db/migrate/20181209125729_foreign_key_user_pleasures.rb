class ForeignKeyUserPleasures < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :user_pleasures, :users, index: true, foreign_key: true
    add_foreign_key :user_pleasures, :pleasures, index: true, foreign_key: true
  end
end
