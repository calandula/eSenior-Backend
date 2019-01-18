class IndexOverMailReceiver < ActiveRecord::Migration[5.2]
  def change
    add_index :mails, :receiver
  end
end
