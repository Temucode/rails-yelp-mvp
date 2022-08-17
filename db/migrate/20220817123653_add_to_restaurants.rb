class AddToRestaurants < ActiveRecord::Migration[7.0]
  def change
    add_column :restaurants, :phone_number, :string
    add_column :restaurants, :category, :string
  end
end
