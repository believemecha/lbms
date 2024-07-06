# config/initializers/cors.rb
Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins 'http://localhost:3000'  # Replace with your Next.js app URL or '*' for any origin
  
      resource '*',
        headers: :any,
        methods: [:get, :post, :put, :patch, :delete, :options, :head],
        credentials: true  # Allow cookies to be sent cross-origin
    end
end
  