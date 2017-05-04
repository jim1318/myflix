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




end