require 'spec_helper'
require 'shoulda/matchers'

describe User do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:password).on(:create) }
  it { should validate_length_of(:password).is_at_least(5) }
  it { should validate_confirmation_of(:password) }
  it { should have_secure_password }
  it { should have_many(:wines) }

  describe "#total_bottles" do
    it "returns the total number of bottles owned by the user" do
      user = Fabricate(:user)
      wine1 = Fabricate(:wine, user: user)
      wine2 = Fabricate(:wine, user: user)
      wine3 = Fabricate(:wine, user: user)
      total = wine1.quantity + wine2.quantity + wine3.quantity
      expect(user.total_bottles).to eq(total)
    end
  end

end