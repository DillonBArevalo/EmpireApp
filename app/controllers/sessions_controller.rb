class SessionsController < ApplicationController
  # get /login
  def new
    @user = User.new
  end

  # post /login
  def create
    @user = User.find_by(username: login_params[:username])
    if @user && @user.try(:authenticate, login_params[:password])
      session[:id] = @user.id
      redirect_to @user
    else
      @errors = ['Username or password is incorrect!']
      @user = User.new({username: login_params[:username]}) unless @user
      render 'new'
    end
  end

  # delete /logout
  def destroy
    session[:id] = nil
    redirect_to '/'
  end

  private

  def login_params
    params.require(:user).permit(:username, :password)
  end

end
