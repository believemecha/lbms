class MagicLink < ApplicationRecord

    after_save :generate_code

    enum link_type: {
        internal: 0,
        external: 1
    }

    def self.ransackable_attributes(auth_object = nil)
        ["link_type", "redirect_to", "auth_user_id", "code", "expires_on", "created_at", "updated_at","description","url"]
    end

    def self.ransackable_associations(auth_object = nil)
        []
    end

    def expired?
        Time.zone.now > expires_on
    end

    private

    def generate_code
        return if code.present?
        loop do
          @code = Time.now.to_i.to_s + SecureRandom.hex(64).upcase
          break @code unless MagicLink.exists?(code: @code)
        end
        self.code = @code
        base_url = Rails.env == "development" ? "http://localhost:3001" : "https://www.jalalpur.in"
        self.url = "#{base_url}/ai_magic/#{@code}"
        self.save
    end

end
