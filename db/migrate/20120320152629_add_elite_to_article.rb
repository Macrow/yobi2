class AddEliteToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :is_elite, :boolean, :default => false
  end
end
