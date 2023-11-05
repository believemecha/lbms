class CallLog < ApplicationRecord
    belongs_to :user

    enum call_type:{
        outgoing: 0,
        incoming: 1,
        missed: 2
    }

    def self.ransackable_attributes(auth_object = nil)
        ["call_end_time", "call_start_time", "call_type", "created_at", "duration", "id", "name", "phone_number", "updated_at", "user_id"]
    end
end
