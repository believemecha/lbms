class Organization < ApplicationRecord
    has_many :users
    has_many :whatsapp_templates
    belongs_to :owner, class_name: "User", foreign_key: "owner_id"

    def self.ransackable_attributes(auth_object = nil)
        ["address", "created_at", "email_address", "id", "logo_url", "name", "phone_number", "updated_at", "website", "whatsapp_number","owner_id","webhook_url"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["users", "whatsapp_templates"]
    end

end
