class ChangeCocktails < ActiveRecord::Migration[5.2]
  def change
    change_table :cocktails do |t|
      t.string :pic
    end
  end
end
