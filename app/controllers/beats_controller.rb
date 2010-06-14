class BeatsController < ApplicationController
  before_filter :login_required

  # POST /beats
  # POST /beats.xml
  def create
    @beat = Beat.new(params[:beat])
    @beat.user_id = @current_user.id
   
    respond_to do |format|
      if @beat.save
        if params[:reply_to_beat_id] and Beat.find(params[:reply_to_beat_id])
          Comment.create(:source_beat_id => params[:reply_to_beat_id], :comment_beat_id => @beat.id)
        end
        flash[:notice] = 'Beat was successfully created.'
        format.html { redirect_to(home_users_url) }
        format.xml  { render :xml => @beat, :status => :created, :location => @beat }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @beat.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
   @beat = current_user.beats.find(params[:id])
   if @beat
     Comment.delete_all(['source_beat_id = :beat_id OR comment_beat_id = :beat_id',{:beat_id => @beat.id}])
     @beat.destroy
     render :nothing => true
   end
  end
  #def comment
  #end
  #def search
  #end

end
