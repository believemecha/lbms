class GptPrompt < ApplicationRecord
    has_one :gpt_prompt_response

    def get_prompt_response
        res = gpt_prompt_response
        if res.present?
            return res.response
        else
            gpt_res = GptPromptResponse.new(gpt_prompt_id: id,prompt: prompt)
            gpt_res.response = get_response(prompt)
            gpt_res.save
            return gpt_res.response
        end
    end

    private

    def get_response(prompt)
        key = "sk-proj-iolYVKXaUGy0mm3NdbixT3BlbkFJYmxSrlGIZ5DdSvILby8F"
       
         # Set up the endpoint and request parameters
         uri = URI.parse("https://api.openai.com/v1/chat/completions")
         header = {
           "Content-Type" => "application/json",
           "Authorization" => "Bearer #{key}"
         }
       
         # Prepare the request body
         body = {
           "model" => "gpt-3.5-turbo",
           "messages" => [
             {
               "role" => "user",
               "content" => prompt
             },
           ]
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
end