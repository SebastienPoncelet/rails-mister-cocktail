puts 'deleting ingredients...'
Ingredient.delete_all

ingredient_serialized = File.read(File.join(File.dirname(__FILE__), 'seed_data/ingredients.json'))

data = JSON.parse(ingredient_serialized)
drinks = data['drinks']

puts 'creating ingredients...'
drinks.each do |ingredient|
  Ingredient.create(name: ingredient["strIngredient1"])
end

puts "Added #{Ingredient.count} ingredients."
