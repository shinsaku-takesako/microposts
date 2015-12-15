class UsersController < ApplicationController

  before_action :logged_in_user, only: [:edit, :update, :followings, :followers]
  before_action :correct_user, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Update your profile was successful."
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def followings
    @title = "Followings"
    @user = User.find(params[:id])
    @follow_users = @user.following_users
    render 'show_follow' 
  end
  
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @follow_users = @user.follower_users
    render 'show_follow'
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :area, :profile)
  end
  
  def correct_user
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to root_path
    end
  end
end
