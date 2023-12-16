class Product < ApplicationRecord

    scope :description_cont, ->(query) { where("description ILIKE ?", "%#{query}%") }

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "description", "id", "image_url", "keywords", "max_price", "name", "product_category_id", "type", "updated_at"]
    end


    enum type: {
        veg: 0,
        non_veg: 1,
        vegan: 2, 
       }
end
