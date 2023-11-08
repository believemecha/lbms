class CallLog < ApplicationRecord
    include WebhookHelper
    
    belongs_to :user

    after_create :process_data

    enum call_type:{
        outgoing: 0,
        incoming: 1,
        missed: 2
    }

    def self.ransackable_attributes(auth_object = nil)
        ["call_end_time", "call_start_time", "call_type", "created_at", "duration", "id", "name", "phone_number", "updated_at", "user_id"]
    end

    private
    def process_data
        send_log_to_consumer_portal("http://localhost:6000/",self.to_json)
    end
end
