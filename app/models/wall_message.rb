class WallMessage < ApplicationRecord
  belongs_to :user
	validate :texto
  validate :user_id
end
