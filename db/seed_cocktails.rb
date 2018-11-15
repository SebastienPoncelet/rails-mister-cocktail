require 'json'
require 'open-uri'

puts 'deleting cocktails and doses...'
Dose.delete_all
Cocktail.delete_all

puts 'fetching cocktail data...'
url = 'https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail'

cocktails_serialized = open(url).read
data = JSON.parse(cocktails_serialized)
drinks = data['drinks']

puts 'creating cocktails...'
drinks.each do |drink|

  thecocktaildb_id = drink['idDrink']

  drink_url = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=#{thecocktaildb_id}"
  s = open(drink_url).read
  d = JSON.parse(s)

  drink = d['drinks'][0]

  c = Cocktail.new(name: drink["strDrink"], pic: drink["strDrinkThumb"], description: drink['strInstructions'])

  doses = (1..15).to_a.map do |n|
    name = drink["strIngredient#{n}"]

    ingredient = Ingredient.find_by(name: name)

    (name.nil? || name.empty? || ingredient.nil?) && next

    qty_raw = drink["strMeasure#{n}"]
    qty_unit = %w[ml cl g oz].find { |unit| qty_raw.end_with? unit }

    qty = qty_unit.nil? ? qty_raw : qty_raw[0..-qty_unit.length].strip

    qty_unit ||= 'unit'

    Dose.new(cocktail: c, ingredient: ingredient, qty: qty, qty_unit: qty_unit, qty_raw: qty_raw)
  end

  doses = doses.reject { |el| el.nil? }

  c.doses = doses

  c.save
end

puts "Added #{Cocktail.count} cocktails."
