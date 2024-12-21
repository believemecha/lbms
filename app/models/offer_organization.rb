class OfferOrganization < ApplicationRecord
    has_many :offer_organization_students, dependent: :destroy

    before_create :generate_code

    # validates :name, presence: true
    # validates :code, presence: true, uniqueness: true


    private

    def generate_code
        return if code.present?
        loop do
          @code = Time.now.to_i.to_s + SecureRandom.hex(64 / 8).upcase
          break @code unless OfferOrganization.exists?(code: @code)
        end
        self.code = @code
    end
end