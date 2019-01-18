class CreateMails < ActiveRecord::Migration[5.2]
  def change
    create_table :mails do |t|
      t.string :sender
      t.string :receiver
      t.text :message

      t.timestamps
    end
  end
end
