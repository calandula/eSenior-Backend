class Quedada < ApplicationRecord
  belongs_to :user
  has_one :tablero
end
