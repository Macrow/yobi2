module Admin
  class CategoriesController < BaseController
    actions :all
    
    def index
      index!{ @categories = Category.scoped.arrange(:order => :position) }
    end
    
    def sort
      params[:category].sort { |a, b| a <=> b }.each_with_index do |id, index|
        value = id[1][:id]
        position = id[1][:position]
        position = position.to_i + 1
        parent = id[1][:parent_id]
        Category.update(value, :position => position, :parent_id => parent)
      end
      render :nothing => true
    end
  end
end
