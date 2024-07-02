# app/mailers/user_mailer.rb
class UserMailer < ApplicationMailer
  default from: 'programador.rails@gmail.com'

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Our Application')
  end
end
