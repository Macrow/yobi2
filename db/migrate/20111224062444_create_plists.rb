class CreatePlists < ActiveRecord::Migration
  def change
    create_table :plists do |t|
      t.string :name
    end
    
    add_index :plists, :name, :unique => true
  end
end
