class SessionsController < ApplicationController
  # get /login
  def new
    @user = User.new
    respond_to do |f|
      f.html {}
      f.js {@header = 'Login'}
    end
  end

  # post /login
  def create
    @user = User.find_by(username: login_params[:username])
    if @user && @user.try(:authenticate, login_params[:password])
      session[:id] = @user.id
      respond_to do |f|
        f.html {redirect_to @user}
        f.js {render 'modals/reload'}
      end
    else
      @errors = ['Username or password is incorrect!']
      @user = User.new({username: login_params[:username]}) unless @user
      respond_to do |f|
        f.html {render 'new'}
        f.js {render 'modals/errors'}
      end
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
