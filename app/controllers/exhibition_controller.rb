class ExhibitionController < ApplicationController
  # before_action :authenticate_user!, except: [:index, :main]
  def index
    render layout: 'index'
  end

  def main
    @exhibitions = Exhibition.all
    @exhibiRandom = Exhibition.first(6)
  end
  def create
    exhibi = Exhibition.create(title: params[:title], imageAddress: params[:imageAddress], dateStart: params[:dateStart],dateEnd: params[:dateEnd],location: params[:location], spot: params[:spot], time: params[:time], callCenter: params[:callCenter],price: params[:price])
    # exhibi.save
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
    reply = Reply.create(content: params[:content], exhibition_id: params[:exhibition_id])
    redirect_to :back
  end
  
end
