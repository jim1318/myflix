# config/initializers/stripe.rb
Stripe.api_key = ENV['STRIPE_API_KEY'] # e.g. sk_live_1234

StripeEvent.configure do
  subscribe 'charge.succeeded' do |event|
    binding.pry
    user = User.where(customer_token: event.data.object.customer).first
    Payment.create(user: user)
  end
end