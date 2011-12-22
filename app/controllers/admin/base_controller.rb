module Admin
  class BaseController < ::InheritedResources::Base
    layout "admin"
    include_kindeditor :only => [:new, :create, :edit, :update]
    protect_from_forgery
    before_filter :authenticate_admin!
    
    respond_to :html

    private

    def authenticate_admin!
      unless (authenticate_user! && current_user.is_admin)
        redirect_to root_path, :notice => t("user.unauthorized")
      end
    end
  end
end