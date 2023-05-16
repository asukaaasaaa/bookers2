class UsersController < ApplicationController
  def show
   @user = User.find(params[:id])
   @post_books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    flash[:notice] = "You have updated user successfully."
    redirect_to user_path(@user.id)
  end

  def index
    @user = User.all
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
