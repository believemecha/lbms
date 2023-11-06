class Organization < ApplicationRecord
    has_many :users

    def self.ransackable_attributes(auth_object = nil)
        ["address", "created_at", "email_address", "id", "logo_url", "name", "phone_number", "updated_at", "website", "whatsapp_number"]
    end
    
    def self.ransackable_associations(auth_object = nil)
        ["users"]
    end

end
