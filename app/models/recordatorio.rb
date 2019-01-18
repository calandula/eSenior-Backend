class Recordatorio < ApplicationRecord
  belongs_to :user
  validate :data
	validate :texto
  validate :user_id
  validate :time
end
