class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
    respond_to do |f|
      f.html {}
      f.js {@header = 'Register'}
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:id] = @user.id
      redirect_to @user
      # maybe flash a notice?
    else
      @errors = @user.errors.full_messages
      respond_to do |f|
        f.html {render 'new'}
        f.js {}
      end
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
