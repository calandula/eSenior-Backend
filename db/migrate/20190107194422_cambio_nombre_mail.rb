class CambioNombreMail < ActiveRecord::Migration[5.2]
  def change
    rename_table :mails, :messages
  end
end
