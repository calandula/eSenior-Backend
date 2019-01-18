class ReadBooleanMailNewColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :mails, :read, :boolean, :default => false
  end
end
