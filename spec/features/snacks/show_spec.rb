require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "when I visit a snack show page" do
    it "I see the info for a snack and the vending machines the snack is in" do
      owner = Owner.create(name: "Sam's Snacks")
      dons  = owner.machines.create(location: "Don's Mixed Drinks")

      burger = Snack.create!(name: "White Castle Burger", price_in_cents: 3.50)
      pop_rocks = Snack.create!(name: "Pop Rocks", price_in_cents: 1.50)
      cheetos = Snack.create!(name: "Flaming Hot Cheetos", price_in_cents: 2.50)

      dons.snacks << [burger, pop_rocks, cheetos]

      owner = Owner.create(name: "Ali's Snacks")
      johns  = owner.machines.create(location: "Johns's Mixed Snacks")

      johns.snacks << [burger, cheetos]

      visit ("/snacks/#{burger.id}")

      expect(page).to have_content(burger.name)
      expect(page).to have_content("$3.50")

      within "#location-#{dons.id}" do
        expect(page).to have_content(dons.location)
        expect(page).to have_content("3 kinds of snacks")
        expect(page).to have_content(dons.snacks.average_price)
      end

      within "#location-#{johns.id}" do
        expect(page).to have_content(johns.location)
        expect(page).to have_content("2 kinds of snacks")
        expect(page).to have_content(johns.snacks.average_price)

      end
    end
  end
end
