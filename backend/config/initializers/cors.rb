# config/initializers/cors.rb
Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins 'frontend-hostname', 'localhost:3000', '127.0.0.1:3000'
      resource '*',
        headers: :any,
        methods: [:get, :post, :patch, :put, :delete, :options, :head]
    end
  end
  