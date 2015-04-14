require 'spec_helper'

feature "User views and updates profile" do
  scenario "with valid inputs" do
    
    user = Fabricate(:user)
    sign_in(user)

    visit home_path

    click_link "View Profile"

    expect(page).to have_content "Your profile"
    expect(page).to have_content user.name

    click_link "Edit profile"

    expect(page).to have_content "Edit your profile"

    fill_in "Name", with: "Vik"
    click_button "Update Profile"

    expect(page).to have_content "Your profile has been updated!"
    expect(page).to have_content "Vik's Cellar"
  end

  scenario "with invalid inputs" do
    
    user = Fabricate(:user)
    sign_in(user)

    visit home_path

    click_link "View Profile"

    click_link "Edit profile"

    fill_in "Name", with: ""
    click_button "Update Profile"

    expect(page).to have_content "Edit your profile"
    expect(page).to have_content "Please fix the errors below."

  end
end