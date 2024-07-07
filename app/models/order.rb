class Order < ApplicationRecord
    belongs_to :user
    has_many :order_items, dependent: :destroy

    before_create :generate_code

    META_FIELDS = %i[razorpay_order_id payment_link gateway_response payment_params]


    META_FIELDS.each do |key|
        define_method("#{key}?") do
          meta[key.to_s].present? || meta[key].present?
        end
        define_method(key.to_s) do
          meta[key.to_s] || meta[key]
        end
        define_method("#{key}=") do |value = nil|
          meta[key] = value
        end
    end
  
    enum status: {
      pending: "pending",
      processing: "processing",
      cancelled: "cancelled",
      delivered: "delivered",
      refuned: "refuned"
    }
  
    enum payment_status: {
      payment_pending: "payment_pending",
      payment_success: "payment_success",
      payment_failure: "payment_failure"
    }

    private

    def generate_code
        return if code.present?
        loop do
          @code = Time.now.to_i.to_s + SecureRandom.hex(64 / 8).upcase
          break @code unless Order.exists?(code: @code)
        end
        self.code = @code
    end
  end
  