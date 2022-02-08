class UserMailer < ApplicationMailer
  include WickedPdf::PdfHelper

  def registration_confirmation
    @user = params[:user]
    @host = params[:host]
    mail(to: @user.email, from: ENV['email_user_name'], subject: 'Registration Confirmation')
  end

  def patient_sick_leave
    @host = params[:host]
    @patient = params[:patient]
    @doctor = params[:doctor]
    @sick_leave = params[:sick_leave]

    view = render_to_string_with_wicked_pdf(
      pdf: 'view.pdf',
      template: 'user_mailer/patient_sick_leave.html.erb'
    )
    attachments['patient_sick_leave.pdf'] = view

    mail(to: 'andrewtehanov@gmail.com', from: ENV['email_user_name'], subject: 'Sick Leave')
  end
end
