class OfferOrganizationStudent < ApplicationRecord
    belongs_to :offer_organization
  
    validates :name, presence: true
    validates :image_string, presence: true

    before_create :generate_code


    private

    def generate_code
        return if code.present?
        loop do
          @code = Time.now.to_i.to_s + SecureRandom.hex(64 / 8).upcase
          break @code unless OfferOrganizationStudent.exists?(code: @code)
        end
        self.code = @code
    end
end