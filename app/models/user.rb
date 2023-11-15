class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_create :set_default_attrs

    enum user_type: {
      student: 0,
      school: 1,
      college: 2,
      admin: 3
    }  
    
    enum education_level: {
      ninth: 0,
      tenth: 1,
      eleventh:2,
      twelfth: 3,
      graduation:4
    }

    VALID_TYPES = %w[student school admin college].freeze

    VALID_TYPES.each do |user_role|
      # def admin?
      # def school?
      define_method "#{user_role.underscore}?" do
        user_type == user_role
      end
    end

    def self.ransackable_attributes(auth_object = nil)
      ["age", "area_of_interest", "confirmation_sent_at", "confirmation_token", "confirmed_at", "created_at", "current_sign_in_at", "current_sign_in_ip", "education_level", "email", "encrypted_password", "first_name", "id", "last_name", "last_sign_in_at", "last_sign_in_ip", "phone_number", "remember_created_at", "reset_password_sent_at", "reset_password_token", "sign_in_count", "unconfirmed_email", "updated_at", "user_type"]
    end

    private

    def set_default_attrs
      self.user_type ||= 'student'
    end

end
