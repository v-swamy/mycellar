require 'spec_helper'

feature "User edits, updates and deletes an existing wine" do
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

    click_link "My Winery"
    click_link "delete"

    expect(page).not_to have_content "My Winery"
    expect(Wine.all.count).to eq(0)

  end

  scenario "edits with invalid inputs" do

    user = Fabricate(:user)
    sign_in(user)
    
    Fabricate(:wine, winery: "My Winery", quantity: 6, user: user)

    visit root_path
    expect(page).to have_content "6"

    click_link "My Winery"
    expect(page).to have_content "Edit your wine"

    fill_in "Winery", with: ""
    click_button "update wine"

    expect(page).to have_content "Please fix the below errors."

  end
end