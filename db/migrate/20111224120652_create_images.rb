class CreateImages < ActiveRecord::Migration
  def change
    create_table :product_images do |t|
      t.string :image
      t.integer :product_id
      t.boolean :is_major, :default => false

      t.timestamps
    end
    
    create_table :category_images do |t|
      t.string :image
      t.integer :category_id
      t.boolean :is_major, :default => false

      t.timestamps
    end
    
    create_table :article_images do |t|
      t.string :image
      t.integer :article_id
      t.boolean :is_major, :default => false
    
      t.timestamps
    end
    
    add_index :product_images, :product_id
    add_index :category_images, :category_id
    add_index :article_images, :article_id
  end
end
