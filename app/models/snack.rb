class Snack < ApplicationRecord
  validates_presence_of :name, :price_in_cents

  has_many :machine_snacks
  has_many :machines, through: :machine_snacks

  def self.average_price
    average(:price_in_cents)
  end
end
