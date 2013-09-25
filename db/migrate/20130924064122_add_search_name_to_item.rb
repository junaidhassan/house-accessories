class AddSearchNameToItem < ActiveRecord::Migration
  def change
    add_column :items, :search_name, :string
  end
end
