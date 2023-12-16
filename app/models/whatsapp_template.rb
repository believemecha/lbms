class WhatsappTemplate < ApplicationRecord
    belongs_to :organization
    # # Validation rules for the attributes
    # validates :organization_id, presence: true, numericality: { only_integer: true }
    # validates :name, presence: true, length: { maximum: 255 }
    # validates :body, presence: true
    # validates :header, length: { maximum: 255 }
    # validates :footer, length: { maximum: 255 }
    # validates :image_url, length: { maximum: 255 }
    # validates :weekday, inclusion: { in: %w(Monday Tuesday Wednesday Thursday Friday Saturday Sunday) }
    # validates :send_website_url, inclusion: { in: [true, false] }
    # validates :created_at, presence: true
    # validates :updated_at, presence: true

    def self.ransackable_attributes(auth_object = nil)
      ["body", "created_at", "footer", "header", "id", "image_url", "name", "organization_id", "send_website_url", "updated_at", "weekday"]
    end
  end
  