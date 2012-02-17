class Property < ActiveRecord::Base
  belongs_to :product
  validates_presence_of :name, :value
  attr_accessor :name_entered
  
  default_scope order("created_at DESC")
end
