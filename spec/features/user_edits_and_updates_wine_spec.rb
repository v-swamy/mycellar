require 'spec_helper'

feature "User edits and updates an existing wine" do
  scenario "with valid inputs" do

    user = Fabricate(:user)
    sign_in(user)
    
    Fabricate(:wine, winery: "My Winery", quantity: 6, user: user)

    visit root_path
    expect(page).to have_content "6"

    click_link "My Winery"
    expect(page).to have_content "Edit your wine"

    fill_in "Quantity", with: 12
    click_button "update wine"

    expect(page).to have_content "Your wine has been updated!"
    expect(page).to have_content "12"


  end
end