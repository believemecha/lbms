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

    VALID_TYPES = %w[student school admin college].freeze

    VALID_TYPES.each do |user_role|
      # def admin?
      # def school?
      define_method "#{user_role.underscore}?" do
        user_type == user_role
      end
    end
  
  
    def self.ransackable_attributes(auth_object = nil)
      ["address", "admission_taken", "age", "confirmation_sent_at", "confirmation_token", "confirmed_at", "country", "created_at", "current_sign_in_at", "current_sign_in_ip", "dob", "email", "encrypted_password", "first_name", "id", "interested_program", "last_name", "last_sign_in_at", "last_sign_in_ip", "phone_number", "qualification", "remember_created_at", "reset_password_sent_at", "reset_password_token", "school_address", "school_name", "score", "sign_in_count", "stream", "unconfirmed_email", "updated_at", "user_type"]
    end
    def self.ransackable_associations(auth_object = nil)
      ["question_banks"]
    end
    private

    def set_default_attrs
      self.user_type ||= 'student'
    end

end
