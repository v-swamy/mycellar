# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

stella = User.new(name: "Stella", email: "stella@gmail.com", password: "stellababy")

Wine.create(winery: "Barnett Vineyards", name: "Rattlesnake Hill", varietal: "Cabernet Sauvignon", vintage: 2012, region: "Napa Valley", appellation: "Spring Mountain",
  state: "CA", country: "USA", quantity: 12, user: stella)
Wine.create(winery: "Chateau Mouton Rothschild", varietal: "Bordeaux Blend", vintage: 1986, region: "Bordeaux", appellation: "Pauillac",
  country: "France", quantity: 6, user: stella)
Wine.create(winery: "Stag's Leap Wine Cellars", name: "Fay", varietal: "Cabernet Sauvignon", vintage: 2007, region: "Napa Valley", appellation: "Stag's Leap",
  state: "CA", country: "USA", quantity: 4, user: stella)
Wine.create(winery: "Opus One", varietal: "Bordeaux Blend", vintage: 2008, region: "Napa Valley", appellation: "Oakville",
  state: "CA", country: "USA", quantity: 12, user: stella)
