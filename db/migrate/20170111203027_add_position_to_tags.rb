class AddPositionToTags < ActiveRecord::Migration[5.0]
  def change
    add_column :tags, :position, :string
  end
end
