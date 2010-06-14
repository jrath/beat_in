class HomeController < ApplicationController
  
  def index
   redirect_to(home_users_url) if logged_in?
  end
end
