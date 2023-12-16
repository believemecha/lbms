class Library < ApplicationRecord
    def self.ransackable_attributes(auth_object = nil)
        ["name", "location", "capacity", "description", "founded_year", "annual_budget", "num_staff", "num_books", "num_members", "offers_membership", "has_cafeteria", "has_meeting_rooms"]
    end
end
