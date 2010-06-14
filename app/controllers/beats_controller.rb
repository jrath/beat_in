class BeatsController < ApplicationController
  before_filter :login_required

  # POST /beats
  # POST /beats.xml
  def create
    @beat = Beat.new(params[:beat])
    @beat.user_id = @current_user.id

    respond_to do |format|
      if @beat.save
        flash[:notice] = 'Beat was successfully created.'
        format.html { redirect_to(home_users_url) }
        format.xml  { render :xml => @beat, :status => :created, :location => @beat }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @beat.errors, :status => :unprocessable_entity }
      end
    end
  end
  #def comment
  #end
  #def search
  #end

end
