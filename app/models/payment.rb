class Payment < ApplicationRecord

    before_create :generate_code

    enum status: {
        pending: 0,
        success: 1,
        failed: 2
    }

    private

    def generate_code
        return if code.present?
        loop do
          @code = Time.now.to_i.to_s + SecureRandom.hex(64 / 8).upcase
          break @code unless Payment.exists?(code: @code)
        end
        self.code = @code
    end
end
