class UserOtp < ApplicationRecord
    validates :user_id, :purpose, :otp, presence: true

    enum purpose: {
        login_otp:0,
        reset_password:1
    }

    enum status: {
        generated:0,
        verified:1
    }
  end
  