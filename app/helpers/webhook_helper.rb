module WebhookHelper
    extend self
    require 'net/http'
  
    def send_log_to_consumer_portal(end_point, payload)
      return if !end_point.present?
      begin
        api_url = URI.parse(end_point)
        json_payload = payload
  
        http = Net::HTTP.new(api_url.host, api_url.port)
        http.use_ssl = (api_url.scheme == 'https')
  
        request = Net::HTTP::Post.new(api_url.request_uri, 'Content-Type' => 'application/json')
        request.body = json_payload
  
        response = http.request(request)
  
        if response.is_a?(Net::HTTPSuccess)
          result = JSON.parse(response.body)
          return result
        else
          send_error_email("API request failed with status code #{response.code}")
          return { error: 'API request failed' }
        end
      rescue StandardError => e
        send_error_email("API request failed with an exception: #{e.message}\n\n\n\n Payload: #{payload}\n\n endpoint:#{end_point}")
        return { error: 'API request failed due to an exception' }
      end
    end
  
    private
  
    def send_error_email(message)
      admin_email = ['lbsingh732196@gmail.com']
      subject = 'Error :WebhookHelper::send_log_to_consumer_portal '
      ErrorMailer.error_notification(admin_email, subject, message).deliver_now
    end
end
  