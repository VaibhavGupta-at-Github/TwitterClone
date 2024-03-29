class UsersController < ApplicationController
  before_action :authenticate_user! 


  def index
    @users = User.all
  end
  def show
    @user= User.find(params[:id])

    if @user === nil
      flash.now[:alert] = "You should be logged in to view your profile."
      redirect_to root_path
    end
  end

  def follow
    @user = User.find(params[:id])
    current_user.followees << @user
    redirect_back(fallback_location: user_path(@user))
  end 

  def unfollow
    @user = User.find(params[:id])
    current_user.followed_users.find_by(followee_id: @user.id).destroy
    redirect_back(fallback_location: user_path(@user))
  end

end
