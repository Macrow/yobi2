class Category < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :url
  has_ancestry
  has_many :products, :dependent => :nullify
  has_many :images, :class_name => "CategoryImage", :dependent => :destroy
  has_one :major_image, :class_name => "CategoryImage", :conditions => ["is_major = ?", true]
  
  before_validation :generate_url
  
  def display_image
    major_image.nil? ? "no-pic-category.jpg" : major_image.image.url
  end
  
  def thumb_image
    major_image.nil? ? "no-pic-category-thumb.jpg" : major_image.image.thumb.url
  end
  
  def self.get_categories_tree
    return ancestry_options(Category.scoped.arrange(:order => :position)) {|i| "#{'>' * i.depth} #{i.name}"}
  end
  
  def self.ancestry_options(items, &block)
    return ancestry_options(items){ |i| "#{'-' * i.depth} #{i.name}" } unless block_given?
    result = []
    items.map do |item, sub_items|
      result << [yield(item), item.id]
      result += ancestry_options(sub_items, &block)
    end
    result
  end
  
  private  
  
  def generate_url
    if self.url.blank?
      self.url = self.name.to_url.to(Yobi::URL_COUNT)
    else
      self.url = self.url.to_url.to(Yobi::URL_COUNT)
    end
  end
end
