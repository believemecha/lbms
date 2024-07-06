require 'net/http'
require 'uri'
require 'json'


def list(prompt)
    key = "sk-proj-iolYVKXaUGy0mm3NdbixT3BlbkFJYmxSrlGIZ5DdSvILby8F"

  # Set up the endpoint and request parameters
  uri = URI.parse("https://api.openai.com/v1/chat/completions")
  header = {
    "Content-Type" => "application/json",
    "Authorization" => "Bearer #{ENV["api_key"]}"
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
  puts response_body["choices"][0]["message"]["content"]
end



def list_educational_prompts(key)
  uri = URI.parse("https://api.openai.com/v1/engines/text-davinci-003/completions")
  header = {
    "Content-Type" => "application/json",
    "Authorization" => "Bearer #{key}"
  }

  body = {
    "prompt" => "Educational prompts:\n1. What is the capital of France?\n2. Explain the concept of photosynthesis.\n3. Name three important events from the American Civil War.\n4. Describe the water cycle.\n5. How does a bill become a law in the United States?\n6. Discuss the importance of the scientific method.\n7. What are the major functions of the human respiratory system?\n8. Explain the difference between a simile and a metaphor.\n9. Name three famous works of Shakespeare and their themes.\n10. Describe the process of cell division (mitosis).",
    "max_tokens" => 50,
    "top_p" => 1.0,
    "temperature" => 0.3,
    "n" => 10
  }.to_json

  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  request = Net::HTTP::Post.new(uri.request_uri, header)
  request.body = body

  response = http.request(request)
  response_body = JSON.parse(response.body)

  prompts = response_body["choices"].map { |choice| choice["text"] }
  prompts.each_with_index { |prompt, index| puts "#{index + 1}. #{prompt}" }
end



GptPrompt.create(prompt: "Generate a story about a space adventure.")
GptPrompt.create(prompt: "Write a poem about the seasons.")
GptPrompt.create(prompt: "Explain the theory of relativity in simple terms.")
GptPrompt.create(prompt: "Create a recipe for a healthy smoothie.")
GptPrompt.create(prompt: "Describe a futuristic city.")
GptPrompt.create(prompt: "Write a letter to your future self.")
GptPrompt.create(prompt: "Generate a workout plan for beginners.")
GptPrompt.create(prompt: "Draft an email for a job application.")
GptPrompt.create(prompt: "Compose a motivational speech.")
GptPrompt.create(prompt: "Outline the steps to start a business.")



GptPrompt.create(prompt: "Correct the following sentences for grammar errors.")
GptPrompt.create(prompt: "Rewrite the given paragraph to improve clarity and coherence.")
GptPrompt.create(prompt: "Identify and correct the grammatical mistakes in the following text.")
GptPrompt.create(prompt: "Improve the grammar in the following sentences.")
GptPrompt.create(prompt: "Edit the given passage to enhance its grammatical accuracy.")
GptPrompt.create(prompt: "Correct the punctuation errors in the following sentences.")
GptPrompt.create(prompt: "Revise the text to ensure grammatical correctness.")
GptPrompt.create(prompt: "Edit the given text to improve its grammar and readability.")
GptPrompt.create(prompt: "Identify and correct any grammatical errors in the following passage.")
GptPrompt.create(prompt: "Rewrite the given sentences to improve their grammar and flow.")
GptPrompt.create(prompt: "Proofread the following text for grammatical mistakes.")
GptPrompt.create(prompt: "Edit the provided text for proper grammar and sentence structure.")
GptPrompt.create(prompt: "Revise the sentences to eliminate any grammatical errors.")
GptPrompt.create(prompt: "Correct the grammar and punctuation in the following sentences.")
GptPrompt.create(prompt: "Improve the grammar and syntax in the given text.")
GptPrompt.create(prompt: "Edit the following sentences to fix any grammatical issues.")
GptPrompt.create(prompt: "Proofread the text and correct any grammatical errors.")
GptPrompt.create(prompt: "Identify and correct the grammar mistakes in the following paragraphs.")
GptPrompt.create(prompt: "Rephrase the sentences to improve their grammatical accuracy.")
GptPrompt.create(prompt: "Correct the grammar in the provided sentences to make them more accurate.")


body = {
           "model" => "gpt-3.5-turbo",
           "messages" => [
             {
               "role" => "user",
               "content" => "write an essay on 2000 words on the imporatnce of gita"
             },
           ]
          }.to_json



          body = {
            "model" => "gpt-3.5-turbo",
            "messages" => payload
          }.to_json
        

"https://www.jalalpur.in/send_text_message?code=lbsingh732196@gmail.com&phone=%2B919431426600&message=hellofromservertophone"