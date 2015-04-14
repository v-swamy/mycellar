require 'spec_helper'

feature "User adds a wine" do

  scenario "with valid inputs" do

    sign_in

    visit root_path
    click_link "Add New Wine"

    expect(page).to have_content("Add a new wine")

    fill_in 'Winery', with: "Random Winery"
    fill_in 'Quantity', with: 12
    click_button "add wine"

    expect(page).to have_content("Random Winery")

  end

  scenario "with invalid inputs" do

    
    sign_in

    visit root_path
    click_link "Add New Wine"

    expect(page).to have_content("Add a new wine")

    click_button "add wine"

    expect(page).to have_content("Please fix the below errors.")

  end
end