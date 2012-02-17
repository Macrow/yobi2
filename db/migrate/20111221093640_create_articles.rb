class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.string :url

      t.timestamps
    end
    
    add_index :articles, :url, :unique => true
  end
end
