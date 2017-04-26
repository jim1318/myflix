require 'spec_helper'

describe UsersController do

  describe "GET new" do
    it "sets @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "POST create" do
    context "with valid input" do
      before { post :create, user: Fabricate.attributes_for(:user) }

      it "creates the user" do
        expect(User.count).to eq(1)
      end

      it "redirects to the sign in page" do
        expect(response).to redirect_to sign_in_path
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

  end 
end