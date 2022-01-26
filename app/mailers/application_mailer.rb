class ApplicationMailer < ActionMailer::Base
  default from: ENV['email_user_name']
  layout 'mailer'
end
