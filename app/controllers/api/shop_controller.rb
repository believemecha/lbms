# app/controllers/api/shop_controller.rb
class Api::ShopController < ApplicationController
    before_action :set_cart, only: [:add_to_cart, :generate_order, :list_orders]
  
    # GET /api/products
    def list_products
      @products = ShopProduct.all
      render json: @products
    end

    def update_cart
        begin
        email = params[:email]
        cart_items = params[:cart_items]
  
        user = User.find_by(email: email)
  
        # Ensure the user has a cart
        cart = user.cart || user.create_cart
  
        cart_items.each do |item|
          product_id = item[:product_id]
          quantity = item[:quantity]
  
          cart_item = cart.cart_items.find_or_initialize_by(shop_product_id: product_id)
  
          if quantity > 0
            cart_item.quantity = quantity
            cart_item.save
          else
            cart_item.destroy if cart_item.persisted?
          end
        end
  
        render json: { status: true,message: "Cart updated successfully" }, status: :ok
        rescue StandardError => e
            render json: { staus: false, message: "Something Went Wrong" }, status: :ok
        end
    end

    def cart_details
        begin
        email = params[:email]
        user = User.find_by(email: email)
        
        # Ensure the user has a cart
        cart = user.cart || user.create_cart
  
        cart_items = cart.cart_items.includes(:shop_product)

        data = []
        cart_items.each do |item|
            dup_item = item.as_json
            dup_item["shop_product"] = item.shop_product.as_json
            data << dup_item
        end

        puts data
            
        render json: { status: true, data: data }, status: :ok
        rescue StandardError => e
            render json: { message: e.message , status: false}, status: :ok
        end
    end
  
  
    # POST /api/add_to_cart
    def add_to_cart
      @product = ShopProduct.find(params[:product_id])
      @cart_item = @cart.cart_items.build(shop_product: @product, quantity: params[:quantity])
      
      if @cart_item.save
        render json: @cart, include: :cart_items, status: :created
      else
        render json: @cart_item.errors, status: :unprocessable_entity
      end
    end
  
    # POST /api/generate_order
    def generate_order
      @order = @cart.user.orders.build(total_price: calculate_total_price, status: 'pending')
  
      if @order.save
        @cart.cart_items.each do |cart_item|
          @order.order_items.create!(
            shop_product_id: cart_item.shop_product_id,
            quantity: cart_item.quantity
          )
        end
  
        # Optionally clear the cart after generating the order
        @cart.cart_items.destroy_all
  
        render json: @order, include: :order_items, status: :created
      else
        render json: @order.errors, status: :unprocessable_entity
      end
    end
  
    # GET /api/orders
    def list_orders
      @orders = @cart.user.orders
      render json: @orders, include: :order_items
    end
  
    private
  
    def set_cart
      @cart = Cart.find_or_create_by(user_id: params[:user_id])
    end
  
    def calculate_total_price
      @cart.cart_items.sum { |item| item.quantity * item.shop_product.price }
    end
end
  