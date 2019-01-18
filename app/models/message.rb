class Message < ApplicationRecord
    validates :sender, presence: true
    validates :receiver, presence: true
    validates :message, presence: true
    validates :title, presence: true
end
