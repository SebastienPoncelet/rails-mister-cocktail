require 'json'
require 'open-uri'

# puts 'fetching ingredient data...'
# url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'

# ingredient_serialized = open(url).read

# File.open(File.join(File.dirname(__FILE__), 'seed_data/ingredients.json'), 'w') { |file| file.write(ingredient_serialized) }

puts 'fetching cocktail data...'
url = 'https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail'

cocktails_serialized = open(url).read
data = JSON.parse(cocktails_serialized)
drinks = data['drinks']

output = []

drinks.each do |drink|

  thecocktaildb_id = drink['idDrink']

  drink_url = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=#{thecocktaildb_id}"
  s = open(drink_url).read
  d = JSON.parse(s)

  output << d

end

puts drinks.length
puts output.length

json = JSON.generate(output)

File.open(File.join(File.dirname(__FILE__), 'seed_data/cocktails_doses.json'), 'w') { |file| file.write(json) }
