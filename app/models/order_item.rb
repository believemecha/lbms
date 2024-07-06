# app/models/order_item.rb
class OrderItem < ApplicationRecord
    belongs_to :order
    belongs_to :shop_product
    validates :quantity, numericality: { greater_than: 0 }
end
  