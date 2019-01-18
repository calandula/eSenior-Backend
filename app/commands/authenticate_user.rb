class AuthenticateUser
    prepend SimpleCommand

    def initialize(email, password)
      @email = email
      @password = password
    end

    def call
      JsonWebToken.encode(user_id: user.id) if user
    end
  
    private

    attr_accessor :email, :password

    def user
      user = User.find_by_email(email)
      if user && user.authenticate(password)
        if user.email_confirmed
          return user
        else
        errors.add :user_authentication, 'not activate'
      end
      else
        errors.add :user_authentication, 'invalid credentials'
        nil
      end
    end
  end
