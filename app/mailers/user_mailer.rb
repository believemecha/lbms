class UserMailer < ApplicationMailer
    def send_email(email, status,logs)
      @status = status
      @logs = logs
      mail(to: email, subject: 'Hourly Analysis::Calllogs')
    end
end