class UsersMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.users_mailer.NewUser.subject
  #
  def NewUser(user)
    @user = user

    mail to: @user.email, subject: "Bienvenido a eSenior, por favor confirme su registro"
  end
end
