module Admin
  class BaseController < ::InheritedResources::Base
    layout "admin"
    include_kindeditor :only => [:new, :create, :edit, :update]
    protect_from_forgery
    before_filter :authenticate_admin!, :count_page
    respond_to :html
    
    def create
      create! do |success, failure|
        success.html { redirect_to get_mutiple_redirect_url }
        failure.html
      end
    end
    
    def update
      update! do |success, failure|
        success.html { redirect_to get_mutiple_redirect_url }
        failure.html
      end
    end
    
    protected
    
    def get_mutiple_redirect_url
      case params[:commit]
      when t("actions.simple.save_and_edit")
        redirect_url = [:edit, :admin, resource]
      when t("actions.simple.save_and_add_another")
        redirect_url = [:new, :admin, resource_class.to_s.downcase.to_sym]
      else
        redirect_url = [:admin, resource_class.to_s.downcase.pluralize.to_sym]
      end
      return redirect_url
    end
    
    private
    
    def authenticate_admin!
      unless (authenticate_user! && current_user.is_admin)
        redirect_to root_path, :notice => t("user.unauthorized")
      end
    end
    
    def count_page
      page = params[:page].nil? ? 1 : params[:page].to_i
      @count_page = (page - 1) * WillPaginate.per_page
    end
  end
end