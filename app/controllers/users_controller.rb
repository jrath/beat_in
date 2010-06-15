class UsersController < ApplicationController
  before_filter :login_required, :only => [:home,:follow]

  # render new.rhtml
  def new
    @user = User.new
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
    else
      flash.now[:notice]  = "Please try again."
      render :action => 'new'
    end
  end

  def activate
    logout_keeping_session!
    user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && user && !user.active?
      user.activate!
      flash[:notice] = "Signup complete! Please sign in to continue."
      redirect_to '/login'
    when params[:activation_code].blank?
      flash[:error] = "The activation code was missing.  Please follow the URL from your email."
      redirect_back_or_default('/')
    else 
      flash[:error]  = "We couldn't find a user with that activation code -- check your email? Or maybe you've already activated -- try signing in."
      redirect_back_or_default('/')
    end
  end

  def home
    
    params[:page] = params[:page].to_i
    limit = 20
    offset = params[:page] * limit

    owner_ids = current_user.followees.collect{|f| f.followee_id}.push current_user.id
    @beats = Beat.find(:all,
                       :conditions => ["user_id IN (#{owner_ids*','})"],
                       :order      => "id DESC",
                       :offset     => offset,
                       :limit      => limit) 
     @beats.reject!{|b| b.id >= params[:last_beat_id].to_i } if params[:last_beat_id]
    if request.xhr?
      render :partial => "/beats/list", :locals => {:beats => @beats, :page => params[:page], :hash => {:url_function => 'home_users_url'}}
    end
  end

  def profile
    params[:page] = params[:page].to_i
    limit = 20
    offset = params[:page] * limit

    @user  = User.find(params[:id])
    if @user
      @beats = @user.beats.find(:all, :offset => offset, :limit => limit)
      @beats.reject!{|b| b.id >= params[:last_beat_id].to_i } if params[:last_beat_id]
      if request.xhr?
        render :partial => "/beats/list", :locals => {:beats => @beats, :page => params[:page], 
                                                      :hash => {:hide_owner => true, 
                                                                :url_function => 'profile_user_url',
                                                                :url_options => {:id => @user.id}
                                                                }
                                                      }
 
      end
    else
      flash[:error]  = "We couldn't find the user."
      redirect_back_or_default('/')
    end
  end

  def search
    params[:page] = params[:page].to_i
    limit = 10
    offset = params[:page] * limit
    unless params[:q].blank?
      words = params[:q].split(' ').collect{|w| "%#{w}%"}
      conditions = (words.collect{|w| "login like ?"}  + words.collect{|w| "name like ?"})*' OR '
      @users = User.find(:all, :conditions => [conditions] + words + words, :offset => offset, :limit => limit)
    else
      @users = []
    end
  end

  def follow
    if params[:id].to_i != current_user.id
      @follow = Follow.find_or_create_by_follower_id_and_followee_id(current_user.id,params[:id])
      render :text => "<b>Following</b>"
    else
      render :text =>  "You need not follow yourself."
    end
  end


  def following
    @user = User.find(params[:id])
    if @user
      @following = @user.followee_users
    else
      flash[:error]  = "We couldn't find the user."
      redirect_back_or_default('/')
    end

  end
  def followers
    @user = User.find(params[:id])
    if @user
      @followers = @user.follower_users
    else
      flash[:error]  = "We couldn't find the user."
      redirect_back_or_default('/')
    end
  end
end
