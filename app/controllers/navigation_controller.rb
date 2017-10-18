class NavigationController < ApplicationController
  def home
  end

  def dropdown
    respond_to do |f|
      f.js {}
    end
  end

  def sub_nav
    @type = params[:type]
    @erb = "/#{params[:type]}/nav"
    respond_to do |f|
      f.js {}
    end
  end
end
