class RaiseAnIssue < ApplicationRecord
    def self.ransackable_attributes(auth_object = nil)
        ["acted_by_user_id", "adding_comments", "created_at", "description", "email_id", "id", "phone_number", "status", "subject", "updated_at", "user_id", "user_type"]
      end
end
