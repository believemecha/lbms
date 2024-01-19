class UserMailer < ApplicationMailer
    def send_email(email, status,logs)
      @status = status
      @logs = logs
      mail(to: email, subject: 'Hourly Analysis::Calllogs')
    end
    
    def otp(id)
      user = User.find_by_id(id)
      @name = user.first_name
      @otp = ""
      6.times do
        @otp = @otp + "#{(0..9).to_a.sample}"
      end
      user_otp = UserOtp.find_or_initialize_by(user_id: user.id,purpose: :login_otp)
      user_otp.otp = @otp
      user_otp.status = :generated
      if user_otp.save
        mail(to: user.email, subject: 'Login Otp')
      end
    end
end