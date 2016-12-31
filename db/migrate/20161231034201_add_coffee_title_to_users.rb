class AddCoffeeTitleToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :coffee_title, :string
  end
end
