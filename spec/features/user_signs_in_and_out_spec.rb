require 'spec_helper'

feature "User signs in and out" do
  scenario "with valid credentials" do
    user = Fabricate(:user)
    sign_in(user)
    expect(page).to have_content(user.name)

    click_link "Sign Out"
    expect(page).to have_content("You've signed out.")
  end

  scenario "with invalid credentials" do
    visit '/sign_in'
    fill_in 'Email', with: "anyone@gmail.com"
    fill_in 'Password', with: "123456"
    click_button 'log in'

    expect(page).to have_content("There is something wrong with your email or password.")
  end


end