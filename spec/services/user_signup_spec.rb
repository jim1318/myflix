require 'spec_helper'

describe UserSignup do
  describe "sign_up" do

    context "valid personal info and valid card" do
      before do
        ActionMailer::Base.deliveries.clear
        customer = double('customer', customer_token: "abcdefg")
        customer_result = double('customer_result', successful?: true, response: customer, customer_token: "abcdefg")
        allow(StripeWrapper::Customer).to receive(:create).and_return(customer_result)
        
        sub_result = double('result', successful?: true, response: "dummy", id: 1)
        allow(StripeWrapper::Subscription).to receive(:create).and_return(sub_result)
      end

      it "creates the user" do
        UserSignup.new(Fabricate.build(:user)).sign_up("some_stripe_token", nil)
        expect(User.count).to eq(1)
      end

      it "stores the customer token from stripe" do
        UserSignup.new(Fabricate.build(:user)).sign_up("some_stripe_token", nil)
        expect(User.first.customer_token).to eq("abcdefg")
      end

      it "makes the user follow the inviter" do
        alice = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: alice, recipient_email: "joe@example.com")
        UserSignup.new(Fabricate.build(:user, email: 'joe@example.com', password: 'password', full_name: 'John Doe')).sign_up("some_stripe_token", invitation.token)
        joe = User.where(email: 'joe@example.com').first
        expect(joe.follows?(alice)).to eq(true)
      end

      it "makes the inviter follow the user" do
        alice = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: alice, recipient_email: "joe@example.com")
        UserSignup.new(Fabricate.build(:user, email: 'joe@example.com', password: 'password', full_name: 'John Doe')).sign_up("some_stripe_token", invitation.token)
        joe = User.where(email: 'joe@example.com').first
        expect(alice.follows?(joe)).to eq(true)
      end

      it "expires the invitaino upon acceptance" do
        alice = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: alice, recipient_email: "joe@example.com")
        UserSignup.new(Fabricate.build(:user, email: 'joe@example.com', password: 'password', full_name: 'John Doe')).sign_up("some_stripe_token", invitation.token)
        expect(Invitation.first.token).to be_nil
      end

      it "sends out the email" do
        UserSignup.new(Fabricate.build(:user, email: 'jim@gmail.com')).sign_up("some_stripe_token", nil)
        expect(ActionMailer::Base.deliveries).to_not be_empty
      end
      
      it "sends to the right recipient" do
        UserSignup.new(Fabricate.build(:user, email: 'jim@gmail.com')).sign_up("some_stripe_token", nil)
        message = ActionMailer::Base.deliveries.last 
        expect(message.to).to eq(["jim@gmail.com"])
      end
      
      it "has the right content" do
        UserSignup.new(Fabricate.build(:user, email: 'jim@gmail.com', full_name: 'Jim Finnigan')).sign_up("some_stripe_token", nil)
        message = ActionMailer::Base.deliveries.last 
        expect(message.body).to include("Welcome to MyFlix, Jim Finnigan!")
      end

    end

    context "valid personal info and declined card" do
      it "does not create a new user record" do
        result = double('result', successful?: true, response: "dummy" )
        allow(StripeWrapper::Customer).to receive(:create).and_return(result)
        charge = double('result', successful?: false, error_message: "Your card was declined" )
        allow(StripeWrapper::Subscription).to receive(:create).and_return(charge)
        UserSignup.new(Fabricate.build(:user)).sign_up('123', nil)
        expect(User.count).to eq(0)
      end
    end

    context "with invalid personal information" do
      before do
        ActionMailer::Base.deliveries.clear
        UserSignup.new(User.new(email: "jim@gmail.com")).sign_up('123123', nil)
      end
      
      it "does not create the user" do
        expect(User.count).to eq(0)
      end

      it "does not send an email with invalid inputs" do
        expect(ActionMailer::Base.deliveries).to be_empty
      end

      it "does not charge the card" do
        expect(StripeWrapper::Charge).not_to receive(:create) 
      end
    end

  end
end