class User < ApplicationRecord
  before_create :confirmation_token

    has_secure_password
    validates :name, presence: true
  	validates :email, presence: true, uniqueness: true
  	has_many :recordatorios
    has_many :friend_requests, dependent: :destroy
    has_many :pending_friends, through: :friend_requests, source: :friend
    has_many :friendships, dependent: :destroy
    has_many :friends, through: :friendships
    has_many :quedadas
    has_many :user_pleasures
    has_many :pleasures, through: :user_pleasures
    has_many :wall_messages

    def remove_friend(friend)
      current_user.friends.destroy(friend)
    end
    
    def email_activate
      self.email_confirmed = true
      self.confirm_token = nil
      save!(:validate => false)
    end
  
end


private
def confirmation_token
      if self.confirm_token.blank?
          self.confirm_token = SecureRandom.urlsafe_base64.to_s
      end
    end