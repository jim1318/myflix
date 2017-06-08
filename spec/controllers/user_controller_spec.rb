require 'spec_helper'

describe UsersController do

  describe "GET new" do
    it "sets @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "POST create" do
    context "valid input" do
      before { post :create, user: Fabricate.attributes_for(:user) }

      it "creates the user" do
        expect(User.count).to eq(1)
      end

      it "redirects to the sign in page" do
        expect(response).to redirect_to sign_in_path
      end

      it "makes the user follow the inviter" do
        alice = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: alice, recipient_email: "joe@example.com")
        post :create, user: { email: 'joe@example.com', password: "password", full_name: 'John Doe'}, invitation_token: invitation.token
        joe = User.where(email: 'joe@example.com').first
        expect(joe.follows?(alice)).to eq(true)
      end

      it "makes the inviter follow the user" do
        alice = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: alice, recipient_email: "joe@example.com")
        post :create, user: { email: 'joe@example.com', password: "password", full_name: 'John Doe'}, invitation_token: invitation.token
        joe = User.where(email: 'joe@example.com').first
        expect(alice.follows?(joe)).to eq(true)
      end

      it "expires the invitaino upon acceptance" do
        alice = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: alice, recipient_email: "joe@example.com")
        post :create, user: { email: 'joe@example.com', password: "password", full_name: 'John Doe'}, invitation_token: invitation.token
        expect(Invitation.first.token).to be_nil
      end

    end

    context "with invalid input" do
      it "does not create the user" do
        post :create, user: { email: "jim@gmail.com", full_name: "Jim Finnigan" }
        expect(User.count).to eq(0)
      end

      it "renders the :new template" do
        post :create, user: { email: "jim@gmail.com", full_name: "Jim Finnigan" }
        expect(response).to render_template :new
      end

      it "sets @user" do
        post :create, user: { email: "jim@gmail.com", full_name: "Jim Finnigan" }
        expect(assigns(:user)).to be_instance_of(User)
      end
    end

    context "email sending" do
      before { ActionMailer::Base.deliveries.clear }
      
      it "sends out the email" do
        post :create, user: { email: "jim@gmail.com", password: "asdfasdf", full_name: "Jim Finnigan" } 
        expect(ActionMailer::Base.deliveries).to_not be_empty
      end
      
      it "sends to the right recipient" do
        post :create, user: { email: "jim@gmail.com", password: "asdfasdf", full_name: "Jim Finnigan" } 
        message = ActionMailer::Base.deliveries.last 
        expect(message.to).to eq(["jim@gmail.com"])
      end
      
      it "has the right content" do
        post :create, user: { email: "jim@gmail.com", password: "asdfasdf", full_name: "Jim Finnigan" } 
        message = ActionMailer::Base.deliveries.last 
        expect(message.body).to include("Welcome to MyFlix, Jim Finnigan!")
      end

      it "does not send an email with invalid inputs" do
        post :create, user: { email: "jim@gmail.com", full_name: "Jim Finnigan" } 
         expect(ActionMailer::Base.deliveries).to be_empty
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