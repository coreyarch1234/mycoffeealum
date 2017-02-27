class CreateConnections < ActiveRecord::Migration[5.0]
  def change
    create_table :connections do |t|
      t.integer :mentor_id
      t.integer :mentee_id

      t.timestamps
    end
  end
end
