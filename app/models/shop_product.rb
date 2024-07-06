# app/models/shop_product.rb
class ShopProduct < ApplicationRecord
    validates :title, :price, :description, :category, :image, presence: true
    validates :price, numericality: { greater_than_or_equal_to: 0 }
  end
  