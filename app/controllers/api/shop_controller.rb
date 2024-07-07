# app/controllers/api/shop_controller.rb
class Api::ShopController < ApplicationController  
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
          id = item[:id]
          
          if id.present?
            cart_item = cart.cart_items.find_or_initialize_by(id: id)
          else
             cart_item = cart.cart_items.find_or_initialize_by(shop_product_id: product_id)
          end


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

    # POST /api/generate_order
    def generate_order
      app_base_url = Rails.env == "development" ? "http://localhost:3000" : "https://nextshop-smoky.vercel.app"
      @user = User.find_by(email: params[:email])
      @cart =  @user.cart || @user.create_cart
      total_price =  @cart.cart_items.sum { |item| item.quantity * item.shop_product.price }

      @order = @cart.user.orders.build(total_price: total_price, status: :pending)
  
      if @order.save
        @cart.cart_items.each do |cart_item|
          @order.order_items.create!(
            shop_product_id: cart_item.shop_product_id,
            quantity: cart_item.quantity
          )
        end

        Razorpay.setup('rzp_test_AmGzmG8ko745WJ', '4qVBexEnx78hyZnGnYUVrImT')
        
        payment_callback_url = "#{app_base_url}/shop/payments/collect/#{@order.code}"

        razorpay_order = Razorpay::Order.create(
          amount: (total_price * 100).to_i, # amount in paise
          currency: 'INR',
          receipt: "NEXTORDER_#{@order.code}",
          payment_capture: 1,
          notes: { callback_url: payment_callback_url,callback_method: "get" }
        )
        
        @order.update(meta: { razorpay_order_id: razorpay_order.id,gateway_response: razorpay_order.as_json })

        # Optionally clear the cart after generating the order
        @cart.cart_items.destroy_all
  
        render json: {status: true, data: @order}, include: :order_items, status: :ok
      else
        render json: {status: false, message: "Something Went Wrong"}, status: :ok
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
    

    def order_details
        @order = Order.find_by_code(params[:code])
        return render json: {status: false,message: "Invalid Order Code"} unless @order.present?
        @user = @order.user

        unless @order.status == "success"
            Razorpay.setup('rzp_test_AmGzmG8ko745WJ', '4qVBexEnx78hyZnGnYUVrImT')
            rzp_order = Razorpay::Order.fetch(@order.razorpay_order_id)
            return render json: {status: false,message: "Invalid Razorpay Order"} unless rzp_order.present?
            
            rzp_payments = rzp_order.payments

            successful_payment = rzp_payments.items.select {|x| x["status"] = "captured"}.first

            if successful_payment.present?
                @order.payment_params = successful_payment
                @order.payment_status = "payment_success"
            else
                @order.payment_params = rzp_payments.items.last
            end

            @order.save
        end

        data = @order.as_json
        data["user"] = @order.user.as_json
        data["order_items"] = @order.order_items.map {|x| x.as_json.merge({shop_product: x.shop_product.as_json})}

        return render json: {status: true, data: data}
    end

    # POST /api/orders
    def list_orders
      @user = User.find_by(email: params[:email])
      render json: {status: false,data: [],invalid_user: true} unless @user.present?

      @orders = @user.orders.includes(order_items: :shop_product)
      order_data = []
      @orders.each do |x|
        data = x.as_json
        data["user"] = @user.as_json
        data["order_items"] = x.order_items.map {|x| x.as_json.merge({shop_product: x.shop_product.as_json})}
        order_data << data
      end
      return render json: {status: true, data: order_data}
    end
  
    private
  
    def set_cart
      @cart = Cart.find_or_create_by(user_id: params[:user_id])
    end
  
    def calculate_total_price
      @cart.cart_items.sum { |item| item.quantity * item.shop_product.price }
    end
end
  