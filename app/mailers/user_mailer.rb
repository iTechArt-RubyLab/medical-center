class UserMailer < ApplicationMailer
  def registration_confirmation
    @user = params[:user]
    @host = params[:host]
    mail(to: @user.email, from: ENV['email_user_name'], subject: 'Registration Confirmation')
  end
end
