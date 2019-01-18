class UserPleasure < ApplicationRecord
    has_many :users
    has_many :pleasures
end
