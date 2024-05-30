class GptPrompt < ApplicationRecord
    before_create :generate_code

    MAX_CONVERSATION_LIMIT = 8

    def get_prompt_response(generate_next = false)
        if conversations.length >= MAX_CONVERSATION_LIMIT
            return conversations
        else
            converse = conversations

            next_prompt = conversations.length == 0 ? prompt : "Tell Me More"
            response = get_next_response(next_prompt)
            converse << {
                "role": "assistant",
                "content": response
            }
            self.update(conversations: converse)
            return converse
        end
    end

    private

    def get_next_response(prompt)
        key = ENV.fetch("API_KEY")
       
         # Set up the endpoint and request parameters
         uri = URI.parse("https://api.openai.com/v1/chat/completions")
         header = {
           "Content-Type" => "application/json",
           "Authorization" => "Bearer #{key}"
         }
       
         # Prepare the request body
         body = {
           "model" => "gpt-3.5-turbo",
           "messages" => build_payload(prompt)
         }.to_json
       
         # Create the HTTP request
         http = Net::HTTP.new(uri.host, uri.port)
         http.use_ssl = true
         request = Net::HTTP::Post.new(uri.request_uri, header)
         request.body = body
       
         # Send the request and get the response
         response = http.request(request)
       
         # Parse and print the response body
         response_body = JSON.parse(response.body)
         response_body["choices"][0]["message"]["content"]
    end

    def build_payload(next_prompt)
        payload = conversations
        payload << {
            "role": "user",
            "content": next_prompt
        }
        payload
    end

    def generate_code
        self.code = SecureRandom.hex(8)
    end


end