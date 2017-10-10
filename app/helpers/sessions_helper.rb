module SessionsHelper
  def logged_in?
    !!session[:id]
  end

  def current_user
    @current_user ||= User.find_by(id: session[:id]) if session[:id]
  end

  def current_user?(user)
    user == current_user
  end

  def auth(item = nil)
    if item
      if item.class == Weapon
        unless current_user?(item.user)
          flash.alert = "You are not the owner of #{item.name}"
          redirect_to item
        end
      else
        unless current_user?(item.creator)
          flash.alert = "You are not the owner of #{item.name}"
          redirect_to item
        end
      end
    else
      unless logged_in?
        flash.alert = 'You must be logged in'
        redirect_to login_path
      end
    end
  end
end
