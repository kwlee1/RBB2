class UsersController < ApplicationController
  def index
  end
  
  def create
    @user = User.new(reg_helper)
    if @user.save
        session[:user_id] = @user.id
        redirect_to groups_path 
    else
        flash[:errors] = @user.errors.full_messages
        redirect_to '/'
    end
  end 

  private
  def reg_helper
      params.require(:user).permit(:first_name,:last_name,:email,:password) if params[:user].present?
  end
end
