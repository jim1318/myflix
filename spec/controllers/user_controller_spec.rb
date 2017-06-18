require 'spec_helper'
require 'stripe_mock'

describe UsersController do

  describe "GET new" do
    it "sets @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "POST create", :vcr do

    context "successful user signup" do
      it "redirects to the sign in page" do
        ActionMailer::Base.deliveries.clear
        result = double(:sign_up_result, successful?: true)
        UserSignup.any_instance.should_receive(:sign_up).and_return(result)
        post :create, user: Fabricate.attributes_for(:user) 
        expect(response).to redirect_to sign_in_path
      end
    end

    context "failed user signup" do
      before do
        result = double(:sign_up_result, successful?: false, error_message: "error message")
        UserSignup.any_instance.should_receive(:sign_up).and_return(result)
        post :create, user: Fabricate.attributes_for(:user)
      end

      it "renders the new template" do
        expect(response).to render_template :new
      end

      it "sets @user" do
        expect(assigns(:user)).to be_instance_of(User)
      end

      it "sets the flash error message" do
        expect(flash[:danger]).to be_present
      end

    end
  end 

  describe "GET show" do
    context "with valid credentials" do
      it "sets @user" do
        set_current_user
        alice = Fabricate(:user)
        get :show, id: alice.id
        expect(assigns(:user)).to eq(alice)
      end

    end

    context "without valid credentials" do
      it_behaves_like "requires sign in" do
        let(:action) { get :show, id: 3}
      end
    end
  end

  describe "GET new_with_invitation_token" do
    it "renders the :new view template" do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(response).to render_template :new
    end
    it "sets @user with recipient's email" do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(assigns(:user).email).to eq(invitation.recipient_email)
    end

    it "sets @invitation_token" do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(assigns(:invitation_token)).to eq(invitation.token)
    end

    it "redirects to expired token page for invalid tokens" do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: "123"
      expect(response).to redirect_to expired_token_path
    end
  
  end
end