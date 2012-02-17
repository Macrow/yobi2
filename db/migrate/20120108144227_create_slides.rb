class CreateSlides < ActiveRecord::Migration
  def change
    create_table :slides do |t|
      t.string :image
      t.boolean :is_hide, :default => false
      t.string :url
      t.string :title
      t.string :caption

      t.timestamps
    end
  end
end
