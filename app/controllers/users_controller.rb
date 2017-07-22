class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:id] = @user.id
      redirect_to @user
      # maybe flash a notice?
    else
      @errors = @user.errors.full_messages
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @characters = @user.characters
  end

  private

  def user_params
    params.require(:user).permit(:username, :name, :email, :password, :password_confirmation)
  end

end
