class AddTimeToRecordatorios < ActiveRecord::Migration[5.2]
  def change
    add_column :recordatorios, :time, :Time
  end
end
