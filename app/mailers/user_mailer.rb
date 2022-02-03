class UserMailer < ApplicationMailer
  def registration_confirmation
    @user = params[:user]
    @host = params[:host]
    mail(to: @user.email, from: ENV['email_user_name'], subject: 'Registration Confirmation')
  end

  def appointment_notification
    @receiver = params[:receiver]
    @visit_date = params[:visit_date]
    @visit_cabinet = params[:visit_cabinet]

    mail(to: @receiver.email, from: ENV['email_user_name'], subject: 'Appointment Notification')
  end
end
