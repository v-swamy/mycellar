require 'spec_helper'

describe WinesController do

  describe "GET index" do
    it "sets the @wines variable to the current signed in user's wines" do
      user = Fabricate(:user)
      set_current_user(user)
      wine = Fabricate(:wine, user: user)
      get :index
      expect(assigns(:wines)).to eq([wine])
    end

    it_behaves_like "requires sign in" do
      let(:action) { get :index }
    end
  end

  describe "GET new" do
    it "sets the @wine variable to a new instance of Wine" do
      set_current_user
      get :new
      expect(assigns(:wine)).to be_a_new(Wine)
    end

    it_behaves_like "requires sign in" do
      let(:action) { get :new }
    end
  end

  describe "POST create" do

    let(:user) { Fabricate(:user) }

    before { set_current_user(user) }

    it_behaves_like "requires sign in" do
      let(:action) { post :create, wine: Fabricate.attributes_for(:wine) }
    end

    context "with valid inputs" do

      before { post :create, wine: Fabricate.attributes_for(:wine) }
      
      it "creates a new wine" do
        expect(Wine.count).to eq(1)
      end

      it "sets the user of the new wine to the current user" do
        expect(Wine.first.user).to eq(user)
      end

      it "redirects to root path" do
        expect(response).to redirect_to root_path
      end

      it "sets the flash success message" do
        expect(flash[:success]).to be_present
      end  
    end

    context "with invalid inputs" do

      before { post :create, wine: {vintage: 2012} }

      it "does not create a new wine" do
        expect(Wine.count).to eq(0)
      end

      it "renders the new wine template" do
        expect(response).to render_template "wines/new"
      end
    end
  end

  describe "GET edit" do

    let(:wine) { Fabricate(:wine) }

    it_behaves_like "requires sign in" do
      let(:action) { get :edit, id: wine.id }
    end

    it_behaves_like "access denied" do
      let(:action) { get :edit, id: wine.id }
    end

    it "sets the @wine variable to the selected wine" do
      set_current_user
      get :edit, id: wine.id
      expect(assigns(:wine)).to eq(wine)
    end


  end

  describe "POST update" do

    let(:user) { Fabricate(:user) }
    let(:wine) { Fabricate(:wine, winery: "My Winery", user: user)}
    let(:wine2) { Fabricate(:wine) }

    before { set_current_user(user) }

    it_behaves_like "requires sign in" do
      let(:action) { post :update, id: wine.id, wine: Fabricate.attributes_for(:wine) }
    end

    it_behaves_like "access denied" do
      let(:action) { post :update, id: wine2.id, wine: Fabricate.attributes_for(:wine) }
    end

    it "sets the @wine variable to the selected wine" do
      post :update, id: wine.id, wine: Fabricate.attributes_for(:wine)
      expect(assigns(:wine)).to eq(wine)
    end
    
    context "with valid inputs" do
      it "updates the wine" do
        post :update, id: wine.id, wine: Fabricate.attributes_for(:wine, quantity: 24)
        wine.reload
        expect(wine.quantity).to eq(24)
      end

      it "sets the flash success message" do
        wine = Fabricate(:wine, user: user)
        post :update, id: wine.id, wine: Fabricate.attributes_for(:wine)
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid inputs" do
      it "does not update the wine" do
        wine = Fabricate(:wine, winery: "My Winery", user: user)
        post :update, id: wine.id, wine: Fabricate.attributes_for(:wine, winery: "")
        wine.reload
        expect(wine.winery).to eq("My Winery")
      end

      it "renders the edit wine template" do
        wine = Fabricate(:wine, winery: "My Winery", user: user)
        post :update, id: wine.id, wine: Fabricate.attributes_for(:wine, winery: "")
        wine.reload
        expect(response).to render_template "wines/edit"
      end

      it "sets the flash danger message" do
        wine = Fabricate(:wine, winery: "My Winery", user: user)
        post :update, id: wine.id, wine: Fabricate.attributes_for(:wine, winery: "")
        wine.reload
        expect(flash[:danger]).to be_present
      end
    end
  end

  describe "DELETE destroy" do
    let(:user) { Fabricate(:user) }
    let(:wine) { Fabricate(:wine, user: user)}
    let(:wine2) { Fabricate(:wine) }

    before { set_current_user(user) }

    it_behaves_like "requires sign in" do
      let(:action) { delete :destroy, id: wine.id }
    end

    it_behaves_like "access denied" do
      let(:action) { delete :destroy, id: wine2.id }
    end

    before { delete :destroy, id: wine.id }

    it "sets the @wine variable to the selected wine" do
      expect(assigns(:wine)).to eq(wine)
    end

    it "deletes the wine" do
      expect(Wine.all.count).to eq(0)
    end

    it "sets the flash warning message" do
      expect(flash[:warning]).to be_present
    end
  end
end