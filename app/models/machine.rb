class Machine < ApplicationRecord
  validates_presence_of :location

  belongs_to :owner
  has_many :machine_snacks
  has_many :snacks, through: :machine_snacks

  def number_of_snack_types
    snacks.select(:name).distinct.count
  end
end
