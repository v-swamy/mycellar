require 'spec_helper'
require 'shoulda/matchers'

describe Wine do
  it { should validate_presence_of(:winery) }
  it { should validate_presence_of(:quantity).on(:create) }
  it { should validate_presence_of(:user) }
  it { should belong_to(:user) }

  describe "#delete_if_zero" do
    it "deletes the Wine record if quantity is updated to zero" do
      wine = Fabricate(:wine)
      wine.quantity = 0
      wine.save
      expect(Wine.all).to be_empty
    end
  end
end