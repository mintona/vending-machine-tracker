require 'rails_helper'

RSpec.describe 'When a user visits a vending machine show page', type: :feature do
  scenario 'they see the location of that machine' do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")

    visit machine_path(dons)

    expect(page).to have_content("Don's Mixed Drinks Vending Machine")
  end

  it 'they see the name and price of all snacks for that machine' do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")

    burger = Snack.create!(name: "White Castle Burger", price_in_cents: 3.50)
    pop_rocks = Snack.create!(name: "Pop Rocks", price_in_cents: 1.50)
    cheetos = Snack.create!(name: "Flaming Hot Cheetos", price_in_cents: 2.50)

    dons.snacks << [burger, pop_rocks, cheetos]

    visit machine_path(dons)

    within "#snack-#{burger.id}" do
      expect(page).to have_content(burger.name)
      expect(page).to have_content("$3.50")
    end

    within "#snack-#{pop_rocks.id}" do
      expect(page).to have_content(pop_rocks.name)
      expect(page).to have_content("$1.50")
    end

    within "#snack-#{cheetos.id}" do
      expect(page).to have_content(cheetos.name)
      expect(page).to have_content("$2.50")
    end
    save_and_open_page
  end
end
