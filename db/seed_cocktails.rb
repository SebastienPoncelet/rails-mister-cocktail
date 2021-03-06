puts 'deleting cocktails and doses...'
Dose.delete_all
Cocktail.delete_all

# require 'pry-byebug'

# puts 'fetching cocktail data...'
# url = 'https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail'

# cocktails_serialized = open(url).read
# data = JSON.parse(cocktails_serialized)
# drinks = data['drinks']

cocktails_serialized = File.read(File.join(File.dirname(__FILE__), 'seed_data/cocktails_doses.json'))

data = JSON.parse(cocktails_serialized)

drinks = data

puts 'creating cocktails and doses...'
drinks.each do |drink_outer|


  drink = drink_outer['drinks'][0]

  # debugger


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


url = 'Clt6YuRWQAAdWBm.jpg'
cocktail = Cocktail.new(name: 'martini glass')
cocktail.remote_photo_url = url
cocktail.save


