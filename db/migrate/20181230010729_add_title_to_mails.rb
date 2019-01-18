class AddTitleToMails < ActiveRecord::Migration[5.2]
  def change
    add_column :mails, :title, :text
  end
end
