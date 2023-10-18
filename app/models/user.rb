class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.ransackable_attributes(auth_object = nil)
    ["country_code", "created_at", "email", "first_name", "id", "last_name", "phone", "remember_created_at", "reset_password_sent_at", "role", "updated_at"]
  end

  VALID_TYPES = %w[Admin User].freeze

  VALID_TYPES.each do |user_role|
    # def admin?
    # def user?
    define_method "#{user_role.underscore}?" do
      role == user_role
    end
  end

  
end
