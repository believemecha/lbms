class Product < ApplicationRecord

    scope :description_cont, ->(query) { where("description ILIKE ?", "%#{query}%") }

    def self.ransackable_attributes(auth_object = nil)
        []
    end

    def self.ransackable_associations(auth_object = nil)
        []
    end


    enum type: {
        veg: 0,
        non_veg: 1,
        vegan: 2, 
       }
end
