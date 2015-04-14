require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets the @user variable to a new instance of User" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "POST create" do
    context "with valid inputs" do

      before { post :create, user: Fabricate.attributes_for(:user) }

      it "creates a new user" do
        expect(User.count).to eq(1)
      end

      it "redirects to the root path" do
        expect(response).to redirect_to root_path
      end

      it "sets the flash success message" do
        expect(flash[:success]).to be_present
      end

      it "logs in the user" do
        expect(session[:user_id]).to be_present
      end
    end

    context "with invalid inputs" do
      
      before { post :create, user: {name: "Vik"} }

      it "does not create a new user" do
        expect(User.count).to eq(0)
      end

      it "renders the new template" do
        expect(response).to render_template 'users/new'
      end

      it "sets the flash danger message" do
        expect(flash[:danger]).to be_present
      end

      it "does not log the user in the session" do
        expect(session[:user_id]).not_to be_present
      end
    end
  end

  describe "GET show" do
    it_behaves_like "requires sign in" do
      user = Fabricate(:user)
      let(:action) { get :show, id: user.id }
    end

    it_behaves_like "access denied" do
      let(:action) { get :show, id: Fabricate(:user).id }
    end

    it "sets the @user variable to current user" do
      user = Fabricate(:user)
      set_current_user(user)
      get :show, id: user.id
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "GET edit" do

    it_behaves_like "requires sign in" do
      user = Fabricate(:user)
      let(:action) { get :edit, id: user.id }
    end

    it_behaves_like "access denied" do
      let(:action) { get :show, id: Fabricate(:user).id }
    end

    it "sets the @user variable to current user" do
      user = Fabricate(:user)
      set_current_user(user)
      get :show, id: user.id
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "POST update" do
    it_behaves_like "requires sign in" do
      user = Fabricate(:user)
      let(:action) { post :update, id: user.id }
    end

    it_behaves_like "access denied" do
      let(:action) { post :update, id: Fabricate(:user).id }
    end

    let(:user) { Fabricate(:user, name: "Vik")}

    before { set_current_user(user) }

    it "sets the @user variable to current user" do
      post :update, id: user.id, user: Fabricate.attributes_for(:user)
      expect(assigns(:user)).to eq(user)
    end

    context "with valid inputs" do
      it "updates the user" do
        post :update, id: user.id, user: Fabricate.attributes_for(:user, name: "Eli")
        user.reload
        expect(user.name).to eq("Eli")
      end

      it "sets the flash info message" do
        post :update, id: user.id, user: Fabricate.attributes_for(:user)
        expect(flash[:info]).to be_present
      end
    end

    context "with invalid inputs" do
      it "does not update the user" do
        post :update, id: user.id, user: Fabricate.attributes_for(:user, name: "")
        expect(user.name).to eq("Vik")
      end

      it "renders the edit template" do
        post :update, id: user.id, user: Fabricate.attributes_for(:user, name: "")
        expect(response).to render_template "users/edit"
      end

      it "sets the flash danger message" do
        post :update, id: user.id, user: Fabricate.attributes_for(:user, name: "")
        expect(flash[:danger]).to be_present
      end
    end
  end
end
