class AddColumnsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :title, :text
    add_column :users, :description, :text
    add_column :users, :linkedin_url, :text
  end
end
