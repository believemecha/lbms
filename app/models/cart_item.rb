# app/models/cart_item.rb
class CartItem < ApplicationRecord
    belongs_to :cart
    belongs_to :shop_product
    validates :quantity, numericality: { greater_than: 0 }
end
  