require 'spec_helper'

feature "User sorts wine", js: true do
  scenario "initially sorts wine by winery" do

    user = Fabricate(:user)
    sign_in(user)
    
    Fabricate(:wine, winery: "C Winery", region: "Sonoma", user: user)
    Fabricate(:wine, winery: "A Winery", region: "Bordeaux", user: user)
    Fabricate(:wine, winery: "B Winery", region: "Napa Valley", user: user)
   

    visit root_path

    within(:css, "tbody tr:nth-child(1)") do
      expect(page).to have_content "A Winery"
    end

    within(:css, "tbody tr:nth-child(2)") do
      expect(page).to have_content "B Winery"
    end

    within(:css, "tbody tr:nth-child(3)") do
      expect(page).to have_content "C Winery"
    end
  end

  scenario "should sort by region after clicking on 'region'" do

    user = Fabricate(:user)
    sign_in(user)
    
    Fabricate(:wine, winery: "A Winery", region: "Sonoma", user: user)
    Fabricate(:wine, winery: "B Winery", region: "Napa Valley", user: user)
    Fabricate(:wine, winery: "C Winery", region: "Bordeaux", user: user)

    visit root_path

    expect(page).to have_content "A Winery"

    find("th[data-column='4']").click

    within(:css, "tbody tr:nth-child(1)") do
      expect(page).to have_content "Bordeaux"
    end

    within(:css, "tbody tr:nth-child(2)") do
      expect(page).to have_content "Napa Valley"
    end

    within(:css, "tbody tr:nth-child(3)") do
      expect(page).to have_content "Sonoma"
    end
  end
end