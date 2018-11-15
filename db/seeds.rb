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

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
ingredient_serialized = open(url).read
drinks = JSON.parse(ingredient_serialized)

drinks.each do |ingredient|
  Ingredient.create(ingredient["strIngredient1"])
end
