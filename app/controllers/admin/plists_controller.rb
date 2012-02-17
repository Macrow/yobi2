module Admin
  class PlistsController < BaseController
    actions :all, :except => :show
    
    def create
      create!{ admin_plists_path }
    end
    
    def update
      update!{ admin_plists_path }
    end
  end
end