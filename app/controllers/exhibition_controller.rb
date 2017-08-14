class ExhibitionController < ApplicationController
  # before_action :authenticate_user!, except: [:index, :main]
  impressionist actions: [:show_detail]
  
  def index
    render layout: 'index'
  end

  def main
    @exhibiRandom = Exhibition.first(6)
    
    @exhibitions = Exhibition.all
    #@exhibitions = Exhibition.all.paginate(:page => params[:page], per_page: 5).order("id desc")
    # like = Like.find_by(user_id: user.id, exhibition_id: exhibition_id)
    type = params[:type]
    if type == '조회수순'
      @exhibitions = Exhibition.order('impressions_count DESC')
    elsif type == '좋아요순'
      @exhibitions = Exhibition.joins(:likes).select('exhibitions.*, count(exhibition_id) as "exhibition_count"').group(:exhibition_id).order('exhibition_count desc')     
    else
    end
  end
  
  def create
    exhibi = Exhibition.create(title: params[:title], imageAddress: params[:imageAddress], dateStart: params[:dateStart], dateEnd: params[:dateEnd], location: params[:location], latitude: params[:latitude], longitude: params[:longitude], spot: params[:spot], time: params[:time], callCenter: params[:callCenter],price: params[:price])
    exhibi.save
    redirect_to'/exhibition/show'
  end
  
  def registerForm
  end
  
  def show
    @exhibi = Exhibition.all
  end
  
  def show_detail
    #unless user_signed_in?
    #  redirect_to '/users/sign_in'
    #end
    @exhibi = Exhibition.find(params[:id])
    impressionist(@exhibi)
  end
  
  def calendar
    @exhibi = Exhibition.all
  end
  
  def destroy
    @exhibi_destroy = Exhibition.find(params[:id])
    @exhibi_destroy.destroy
    
    redirect_to'/exhibition/show'
  end

  def location
    # @location_result = Exhibition.search(params[:location])
  end
  
  def keywordResult
    @searchKeyword = params[:search]
    @keyword_result = Exhibition.search(@searchKeyword)
  end
  
  def locationResult
    @location_result = Exhibition.where(location: params[:location])
  end
  
  def like_toggle
    like = Like.find_by(user_id: current_user.id, exhibition_id: params[:exhibition_id])
    if like.nil?
      Like.create(user_id: current_user.id, exhibition_id: params[:exhibition_id])
    else
      like.destroy
    end
    redirect_to :back
  end
  
  def reply_write
    reply = Reply.create(content: params[:content], exhibition_id: params[:exhibition_id], user_id:params[:user])
    redirect_to '/exhibition/show_detail/'+reply.exhibition_id.to_s
  end
  
  def reply_delete
    reply = Reply.find(params[:id])
    reply.destroy
    
    redirect_to :back
  end
  def reply_update_view
    @reply = Reply.find(params[:id])
  end
  def reply_update
    reply = Reply.find(params[:id])
    reply.content = params[:content]
    reply.save
    redirect_to '/exhibition/show_detail/'+reply.exhibition_id.to_s
  end
  def liked_list
  end
  
end
