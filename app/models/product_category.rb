class ProductCategory < ApplicationRecord
    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "description", "id", "keywords", "name", "updated_at"]
    end
    scope :description_cont, ->(query) { where("description ILIKE ?", "%#{query}%") }


    enum name: {
         sweets: 0,
         fast_foods: 1,
         biryani: 2, 
        }



end
