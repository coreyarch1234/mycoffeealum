class AddDomainToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :domain, :string
  end
end
