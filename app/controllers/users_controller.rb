class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = current_user
    redirect_to new_user_session_path if @user.nil?
  end

end
