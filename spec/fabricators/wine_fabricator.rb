Fabricator(:wine) do
  winery { Faker::Company.name }
  name { Faker::Lorem.word }
  varietal { ["Merlot", "Chardonnay", "Pinot Noir"].sample }
  vintage { [2000, 2005, 2010, 2015].sample }
  region { ["Napa Valley", "Sonoma", "Bordeaux", "Willamette Valley"].sample }
  appellation { ["Stag's Leap", "Oakville", "Carneros", "Russian"].sample }
  state { Faker::Address.state_abbr }
  country { ["France", "USA", "Spain", "Italy"].sample }
  quantity { rand(1..12) }
  user { Fabricate(:user) }
end
