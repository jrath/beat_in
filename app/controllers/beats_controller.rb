class BeatsController < ApplicationController
  before_filter :login_required, :except => [:search]

  # POST /beats
  def create
    @beat = Beat.new(params[:beat])
    @beat.user_id = @current_user.id
   
    if @beat.save
      if params[:reply_to_beat_id] and Beat.find(params[:reply_to_beat_id])
        Comment.create(:source_beat_id => params[:reply_to_beat_id], :comment_beat_id => @beat.id)
      end
      render :partial => @beat
    else
      render :nothing => true, :status => 500
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
  def search
    params[:page] = params[:page].to_i
    limit = 10
    @limit = limit
    offset = params[:page] * limit
    unless params[:q].blank?
      words = params[:q].split(' ').collect{|w| "%#{w}%"}
      conditions = words.collect{|w| "content like ?"} *' OR '
      @beats = Beat.find(:all, :conditions => ([conditions] + words), :offset => offset, :limit => limit, :order => 'id DESC')
    else
      @beats = []
    end
  end

end
