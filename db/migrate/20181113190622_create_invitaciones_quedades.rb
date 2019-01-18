class CreateInvitacionesQuedades < ActiveRecord::Migration[5.2]
  def change
    create_table :invitaciones_quedades do |t|
      t.string :user_id
      t.string :quedada_id
      t.string :status

      t.timestamps
    end
  end
end
