module Admin
  class UsersController < BaseController
    actions :all
    before_filter :initial_search, :only => [:index]
    
    def index
      index! { @users = @search.all }
    end
    
    def update
      if params[:user][:password].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      end
      @user = User.find(params[:id])
      @user.update_attributes(params[:user], :as => :admin)
      update! do |success, failure|
        success.html { redirect_to get_mutiple_redirect_url }
        failure.html
      end
    end
    
    private  
    def initial_search
      @search = User.search(params[:search])
    end
  end
end