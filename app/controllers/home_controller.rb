class HomeController < ApplicationController
  
  def index
    redirect_to(home_users_url) if logged_in?
    @beats = Beat.find(:all,:limit => 5, :order => 'id DESC')
  end
end
