# config/initializers/cors.rb
# Rails.application.config.middleware.insert_before 0, Rack::Cors do
#     allow do
#       origins 'https://nextshop-smoky.vercel.app'  # Replace with your Next.js app URL or '*' for any origin
  
#       resource '*',
#         headers: :any,
#         methods: [:get, :post, :put, :patch, :delete, :options, :head],
#         credentials: true  # Allow cookies to be sent cross-origin
#     end
# end
  

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'https://code.wearelive.in'
    resource '*', headers: :any, methods: [:get, :post, :put, :delete]
  end
end
