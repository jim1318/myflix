require 'spec_helper'

describe StripeWrapper, :vcr do
  
  before { StripeWrapper.set_api_key }
  let(:valid_token) do
    Stripe::Token.create( 
      :card => {
        :number => "4242424242424242",
        :exp_month => "3",
        :exp_year => "2020",
        :cvc => "314"
      }
    )
  end

  let(:declined_card_token) do
    Stripe::Token.create( 
      :card => {
        :number => '4000000000000002',
        :exp_month => "3",
        :exp_year => "2020",
        :cvc => "314"
      }
    )
  end

  describe StripeWrapper::Charge do
    context "with valid credit card" do
      it "charges the card successfully", :vcr do
        cust_response = StripeWrapper::Customer.create( email: "test_email", token: valid_token).response
        char_response = StripeWrapper::Charge.create( amount: 300, customer: cust_response, description: "test charge" )
        expect(char_response).to be_successful
      end
    end
    
    context "with invalid credit card" do
      let(:customer) { StripeWrapper::Customer.create( email: "test_email", token: declined_card_token)}
      it "does not charge the card successfully", :vcr do
        expect(customer.error_message).to eq("Your card was declined.")
      end
    end
  end

  describe StripeWrapper::Customer do
    describe ".create" do
      it "creates a customer with a valid card" do
        alice = Fabricate(:user)
        response = StripeWrapper::Customer.create(
          email: alice.email,
          card: valid_token
        )
        expect(response).to be_successful
      end
      
      it "does not create a customer with a declined card" do
        alice = Fabricate(:user)
        response = StripeWrapper::Customer.create(
          email: alice.email,
          token: declined_card_token
        )
        expect(response).not_to be_successful
      end

      it "returns the customer token for a valid card" do
        alice = Fabricate(:user)
        response = StripeWrapper::Customer.create(
          email: alice.email,
          card: valid_token
        )
        expect(response.customer_token).to be_present
      end

      it "returns the error message for declined card" do
        alice = Fabricate(:user)
        response = StripeWrapper::Customer.create(
          email: alice.email,
          token: declined_card_token
        )
        expect(response.error_message).to eq("Your card was declined.")
      end

    end
  end

end
