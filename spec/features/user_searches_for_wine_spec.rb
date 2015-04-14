require 'spec_helper'

feature "User searches for wine", js: true do
  scenario "User searches for Sonoma wines" do

    user = Fabricate(:user)
    sign_in(user)
    
    Fabricate(:wine, winery: "C Winery", region: "Sonoma", user: user)
    Fabricate(:wine, winery: "A Winery", region: "Bordeaux", user: user)
    Fabricate(:wine, winery: "B Winery", region: "Napa Valley", user: user)
   
    visit root_path

    expect(page).to have_content("A Winery")
    expect(page).to have_content("B Winery")
    expect(page).to have_content("C Winery")

    fill_in "Search", with: "napa"

    expect(page).not_to have_content("A Winery")
    expect(page).to have_content("B Winery")
    expect(page).to_not have_content("C Winery")

    fill_in "Search", with: ""

    expect(page).to have_content("A Winery")
    expect(page).to have_content("B Winery")
    expect(page).to have_content("C Winery")

  end 
end