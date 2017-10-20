class GroupsController < ApplicationController
  def index
    @allgroups=Group.all 
  end

  def create
    @group=Group.new(group_helper)
    if @group.save 
      Member.create(user:current_user,group:@group)
      redirect_to groups_path
    else 
        flash[:errors]=@group.errors.full_messages
        redirect_to :back
    end 
  end 

  def show 
    @group = Group.find(params[:id])
    @members = Group.find(params[:id]).members
    @user = Group.find(params[:id]).user
  end 

  def destroy
    group = Group.find(params[:id])
    Member.find_by(group:group).delete
    group.delete 
    redirect_to groups_path
  end 

  def join
    group = Group.find(params[:id])
    Member.create(user:current_user, group:group)
    redirect_to :back 
  end 

  def leave
    Group.find(params[:id]).members.find_by(user:current_user).delete
    redirect_to :back 
  end 

  private
    def group_helper
        params.require(:group).permit(:name,:description).merge(user:current_user) if params[:group].present?
    end
    
end
