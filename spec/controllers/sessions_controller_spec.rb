require 'spec_helper'

describe SessionsController do
  describe "GET new" do
    it "renders the new template for unauthenticated users" do
      get :new
      expect(response).to render_template(:new)
    end

    it "redirects to the wines index page if user is logged in" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to home_path
    end
  end

  describe "POST create" do
    context "with valid credentials" do

      let(:user) { Fabricate(:user) }

      before do
        post :create, email: user.email, password: user.password
      end

      it "puts signed in user in the session" do
        expect(session[:user_id]).to eq(user.id)
      end

      it "redirects to the root path" do
        expect(response).to redirect_to root_path
      end

      it "sets the success flash message" do
        expect(flash[:success]).not_to be_blank
      end
    end

    context "with invalid credentials" do

      before do
        user = Fabricate(:user)
        post :create, email: user.email, password: user.password + 'asdf'
      end

      it "does not put the signed in user in the session" do
        expect(session[:user_id]).to be_nil
      end
      
      it "redirects to sign in path" do
        expect(response).to redirect_to sign_in_path
      end

      it "sets the danger flash message" do
        expect(flash[:danger]).not_to be_blank
      end
    end
  end

  describe "GET destroy" do

    before do
      session[:user_id] = Fabricate(:user).id
      get "destroy"
    end

    it "clears the user session" do
      expect(session[:user_id]).to be_nil
    end

    it "sets the warning flash message" do
      expect(flash[:warning]).not_to be_blank
    end

    it "redirects to root path" do
      expect(response).to redirect_to root_path
    end
  end
end