require 'rails_helper'

RSpec.describe Machine, type: :model do
  describe 'validations' do
    it { should validate_presence_of :location }
    it { should belong_to :owner }
  end

  describe 'relationships' do
    it {should have_many :machine_snacks}
    it {should have_many(:snacks).through(:machine_snacks)}
  end

  describe 'methods' do
    describe 'number_of_snack_types' do
      it "counts number of distinct snacks" do
        owner = Owner.create(name: "Sam's Snacks")
        dons  = owner.machines.create(location: "Don's Mixed Drinks")

        burger = Snack.create!(name: "White Castle Burger", price_in_cents: 3.50)
        pop_rocks = Snack.create!(name: "Pop Rocks", price_in_cents: 1.50)
        cheetos = Snack.create!(name: "Flaming Hot Cheetos", price_in_cents: 2.50)
        other_cheetos = Snack.create!(name: "Flaming Hot Cheetos", price_in_cents: 2.50)

        dons.snacks << [burger, pop_rocks, cheetos]

        expect(dons.number_of_snack_types).to eq(3)
      end
    end
  end
end
