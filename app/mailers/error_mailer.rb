class ErrorMailer < ApplicationMailer
    def error_notification(admin_email, subject, message)
      @message = message
      mail(
        from: "lbsingh732196@gmail.com",
        to: admin_email,
        subject: subject
      ) do |format|
        format.text
      end
    end
  end
  