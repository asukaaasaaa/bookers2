class UsersController < ApplicationController
  
  def show
   @user = User.find(params[:id])
   @post_books = @user.books
  end

  def edit
     is_matching_login_user
    @user = User.find(params[:id])
  end

  def update
   is_matching_login_user

    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def index
    @user = User.all
  end


  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to users_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
