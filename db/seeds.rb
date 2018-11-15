# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Seeding ingredients
# Getting real ingredients from this JSON list: https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list
require 'json'
require 'open-uri'

puts 'deleting...'
Ingredient.delete_all

puts 'fetching data...'
url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
ingredient_serialized = open(url).read
data = JSON.parse(ingredient_serialized)
drinks = data['drinks']

puts 'creating...'
drinks.each do |ingredient|
  Ingredient.create(name: ingredient["strIngredient1"])
end

puts "Added #{Ingredient.count} ingredients."

# Seeding cocktails
Cocktail.create(name: "Godfather")
Cocktail.create(name: "TI' PUNCH")
Cocktail.create(name: "ROB BOY")
Cocktail.create(name: "HANKY PANKY")
Cocktail.create(name: "OLD CUBAN")
Cocktail.create(name: "CHAMPAGNE COCKTAIL")
Cocktail.create(name: "JUNGLE BIRD")
Cocktail.create(name: "WHITE RUSSIAN")
Cocktail.create(name: "VESPER")
Cocktail.create(name: "AMARETTO SOUR")

puts "Added #{Cocktail.count} cocktails."
