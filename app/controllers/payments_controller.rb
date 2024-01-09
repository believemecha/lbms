class PaymentsController < ApplicationController

    require 'net/http'
    require 'uri'
    require 'json'
    require 'base64'
    require 'digest'

    def new_payment_form
      # Render the form for new_payment
    end
  
    def new_payment
        base_url = Rails.env == "development" ? "http://localhost:3001" : "https://jalalpur.in"
        begin
          p_name, p_user_id, p_amount, p_phone = params[:name], params[:user_id], params[:price], params[:phone]
          cred_merchant_id = "OFFERPLANTPGONLINE"
          cred_salt_key = "774325e8-08e0-476c-8906-76ab588d0c23"
          cred_key_index = 1
          merchant_transaction_id = 'OFFERPLANT' + Time.now.to_i.to_s
      
          data = {
            merchantId: cred_merchant_id,
            merchantTransactionId: merchant_transaction_id,
            merchantUserId: 'MUID' + p_user_id.to_s,
            name: p_name,
            amount: p_amount.to_i * 100,
            redirectUrl: "#{base_url}/payments/check_status/#{merchant_transaction_id}",
            redirectMode: 'REDIRECT',
            mobileNumber: p_phone,
            paymentInstrument: {
              type: 'PAY_PAGE'
            }
          }
          payload = JSON.generate(data)
          payload_main = Base64.strict_encode64(payload)
          key_index = 2
          string = "#{payload_main}/pg/v1/pay#{cred_salt_key}"
          sha256 = Digest::SHA256.hexdigest(string)
          checksum = "#{sha256}####{cred_key_index}"
      
          prod_url = "https://api.phonepe.com/apis/hermes/pg/v1/pay"
          
          uri = URI.parse(prod_url)
          http = Net::HTTP.new(uri.host, uri.port)
          http.use_ssl = true
      
          request = Net::HTTP::Post.new(uri.path, {
            'accept' => 'application/json',
            'Content-Type' => 'application/json',
            'X-VERIFY' => checksum
          })
      
          request.body = { request: payload_main }.to_json
      
          response = http.request(request)

          res = JSON.parse(response.body)

          if res['success']
            payment = Payment.new(user_id: p_user_id, name: p_name,amount: p_amount)
            payment.merchant_transaction_id = merchant_transaction_id
            payment.status = :pending
            payment.gateway_params = res['data']
            payment.merchant_id = "test"
            if payment.save
                render json: {status: true,code: payment.merchant_transaction_id, url: res['data']['instrumentResponse']['redirectInfo']['url']}
            else
                render json: {status: false,code: nil, message: "Internal Server Error"}
            end
          else
            render json: {status: false,code: nil, message: "Unable to process from gateway.", res: res}
          end
              rescue StandardError => e
          render json: {
            message: e.message,
            status: false
          }
        end
      end
  
    def check_status
        code_number = params[:code]
        @data = nil
        @payment = Payment.find_by(merchant_transaction_id: code_number)
        if @payment.present? && @payment.pending?
            cred_merchant_id = "OFFERPLANTPGONLINE"
            cred_salt_key = "774325e8-08e0-476c-8906-76ab588d0c23"
            cred_key_index = 1
            merchant_transaction_id = @payment.merchant_transaction_id
            string = "/pg/v1/status/#{cred_merchant_id}/#{merchant_transaction_id}#{cred_salt_key}"
            sha256 = Digest::SHA256.hexdigest(string)
            checksum = "#{sha256}####{cred_key_index}"
        
            prod_url = "https://api.phonepe.com/apis/hermes/pg/v1/status/#{cred_merchant_id}/#{merchant_transaction_id}"
            
            uri = URI.parse(prod_url)
            http = Net::HTTP.new(uri.host, uri.port)
            http.use_ssl = true
        
            request = Net::HTTP::Get.new(uri.path, {
              'accept' => 'application/json',
              'Content-Type' => 'application/json',
              'X-VERIFY' => checksum,
              'X-MERCHANT-ID' => cred_merchant_id
            })
        
            response = http.request(request)
            if response.code == "200"
                @data = JSON.parse(response.body)
                if @data['data']['state'] == "COMPLETED" && @payment.pending?
                    @payment.update(status: :success, gateway_params: @data['data'])
                end
            end
        else
            if @payment.present? && @payment.success?
                @data = JSON.parse({'data': @payment.gateway_params}.to_json)
            end
        end
    end

    def upload_csv
      
    end
end
  