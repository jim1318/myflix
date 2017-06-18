module StripeWrapper

  class Customer
    attr_reader :response, :status

    def initialize(response, status)
      @response = response
      @status = status
    end    

    def self.create(options={})
      StripeWrapper.set_api_key
      begin
        response = Stripe::Customer.create(
          :email => options[:email],
          :source  => options[:token]
        )
        new(response, :success)
      rescue Stripe::CardError => e
        new(e, :error)
      end
    end

    def successful?
      status == :success
    end

    def error_message
      response.message
    end

    def customer_token
      response.id
    end

  end

  class Charge
    attr_reader :response, :status
    
    def initialize(response, status)
      @response = response
      @status = status
    end

    def self.create(options={})
      StripeWrapper.set_api_key
      begin
        response = Stripe::Charge.create(
          :amount      => options[:amount],
          :currency    => 'usd',
          :description => options[:description],
          :customer    => options[:customer].id
        )
        new(response, :success)
      rescue Stripe::CardError => e
        new(e, :error)
      end
    end
  
    def successful?
      status == :success
    end

    def error_message
      response.message
    end
  end

  class Subscription
    attr_reader :response, :status
    
    def initialize(response, status)
      @response = response
      @status = status
    end

    def self.create(options={})
      StripeWrapper.set_api_key
      begin
        response = Stripe::Subscription.create(
          :customer    => options[:customer].id,
          :plan    => 'basic',
        )
        new(response, :success)
      rescue Stripe::CardError => e
        new(e, :error)
      end
    end
  
    def successful?
      status == :success
    end

    def error_message
      response.message
    end
  end

  def self.set_api_key
    Stripe.api_key = ENV['STRIPE_API_KEY']
  end

end