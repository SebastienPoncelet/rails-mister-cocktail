class Dose < ApplicationRecord
  belongs_to :cocktail
  belongs_to :ingredient

  validates :cocktail, presence: true
  validates :ingredient, presence: true
  # validates :qty, presence: true
  # validates :qty_unit, presence: true
  validates :qty_raw, presence: true
  validates_inclusion_of :qty_unit, in: %w[unit ml cl g oz]
end
