class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :url
      t.string :sn
      t.decimal :price_yobi, :scale => 2
      t.decimal :price_retail, :scale => 2
      t.boolean :is_elite
      t.text :description
      t.integer :category_id

      t.timestamps
    end
    
    add_index :products, :url, :unique => true
    add_index :products, :category_id
  end
end
