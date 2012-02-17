class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :url
      t.string :position
      t.string :ancestry
      t.integer :parent_id

      t.timestamps
    end
    
    add_index :categories, :url, :unique => true
  end
end
