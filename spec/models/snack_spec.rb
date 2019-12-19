require 'rails_helper'

RSpec.describe Snack do
  describe "relationships" do
      it {should have_many :machine_snacks}
      it {should have_many(:machines).through(:machine_snacks)}
  end

  describe "methods" do
    describe "average_price" do
      it "calculates average price for a collection of snacks" do
        burger = Snack.create!(name: "White Castle Burger", price_in_cents: 3.50)
        pop_rocks = Snack.create!(name: "Pop Rocks", price_in_cents: 1.50)
        cheetos = Snack.create!(name: "Flaming Hot Cheetos", price_in_cents: 2.50)

        expect(Snack.average_price).to eq(2.50)
      end
    end
  end
end
