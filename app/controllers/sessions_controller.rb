class SessionsController < ApplicationController
  # get /login
  def new
    @user = User.new
  end

  # post /login
  def create
    p 'made it to create'
    @user = User.find_by(params[:username])
    if @user && @user.password == params[:password]
      p 'success'
      session[:id] = @user.id
      redirect_to @user
    else
      @errors = ['Username or password is incorrect!']
      p @errors
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
