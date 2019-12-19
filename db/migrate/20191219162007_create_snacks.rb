class CreateSnacks < ActiveRecord::Migration[5.1]
  def change
    create_table :snacks do |t|
      t.string :name
      t.decimal :price_in_cents

      t.timestamps
    end
  end
end
