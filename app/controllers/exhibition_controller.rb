class ExhibitionController < ApplicationController
  # before_action :authenticate_user!, except: [:index, :main]
  impressionist actions: [:show_detail]
  
  require 'open-uri'
  require 'nokogiri'
  #require 'webrick/httputils'
  #require 'addressable/uri'
  
  def index
    render layout: 'index'
  end

  def main
    @exhibiRandom = Exhibition.all
    
    # @exhibitions = Exhibition.all
    @exhibitions = Exhibition.all.paginate(:page => params[:page], per_page: 10).order("id desc")
    # like = Like.find_by(user_id: user.id, exhibition_id: exhibition_id)
    type = params[:type]
    if type == '조회수순'
      @exhibitions = Exhibition.all.paginate(:page => params[:page], per_page: 10).order("impressions_count DESC")
      # @exhibitions = Exhibition.order('impressions_count DESC')
    elsif type == '좋아요순'
      @exhibitions = Exhibition.joins(:likes).select('exhibitions.*, count(exhibition_id) as "exhibition_count"').group(:exhibition_id).all.paginate(:page => params[:page], per_page: 10).order('exhibition_count desc')     
    else
    end
    
    #value = Date.parse(Exhibition.dateStart) < Date.today
    #if value == true
    #else
    #end
    #@exhibidatarange = Exhibition.where(:created_at => (Exhibition.dataStart)..(Date.today))
    
    #@startdate = params[:dateStart]
    #@enddate = params[:dateEnd]
    #exhidata = Exhibition.where(:created_at => @startdate..@enddate)
    #@exhibidatarange = exhidata.all
   
    @exhibi = Exhibition.all
    # @exhibi.each do |x|
    #   if Time.zone.today.between?(x.dateStart, x.dateEnd)
    #     exhibidatarange = x
    #     exhibidatarange.save
    #   else
    #   end
    # end
    
    @locationAll = Exhibition.uniq.pluck(:location)
    
  end
  
  def create
    exhibi = Exhibition.create(title: params[:title], imageAddress: params[:imageAddress], dateStart: params[:dateStart], dateEnd: params[:dateEnd], location: params[:location], latitude: params[:latitude], longitude: params[:longitude], spot: params[:spot], spot_ascii: params[:spot_ascii], time: params[:time], callCenter: params[:callCenter],price: params[:price],hashtag: params[:hashtag])
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
    
    #교통수단
    url = "https://search.naver.com/search.naver?query="+@exhibi.spot
    url = URI.encode(url)
    doc = Nokogiri::HTML(open(url,'User-Agent' => 'ruby'),nil,'utf-8')
    
    doc.css('dd>dl>dd.subway>ul>li').each do |x|
      @subway = x.inner_text
      # doc.css('dd>dl>dd.subway>ul>li>img src').each do |y|
      #   @subway_img = y
      # end
    end
    
    if @subway.nil?
      @subway = '정보없음'
    end
    
    doc.css('dd>dl>dd.bus>ul>li').each do |x|
      @bus = x.inner_text
    end
    
    if @bus.nil?
      @bus = '정보없음'
    end
    #교통수단
  
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
  
  def hashtags
      @tag = Tag.find_by(tagname: params[:tagname])
      @exhibititons = @tag.exhibitions
  end
  
  def magazine
  end
  
  def magazine_index
    @post = Post.where(spot_name: params[:spot_name])
    #쿼리 : 전시장소에 따라 글 출력
  end
  
  def magazine_create
    post = Post.new
    
    post.title = params[:title]
    post.content = params[:content]
    post.user_id = params[:user]
    post.spot_name = params[:spot_name]
    post.save
    
    redirect_to "/exhibition/magazine"
  end
  
  def magazine_edit
     @edit_post = Post.find(params[:id])
  end
  
  def magazine_update
    edit_post = Post.find(params[:id])
    edit_post.title = params[:title]
    edit_post.content = params[:content]
    edit_post.save
    
    redirect_to "/exhibition/magazine"
  end
  
  def magazine_destroy
    destroy_post = Post.find(params[:id])
    destroy_post.destroy
    
    redirect_to "/exhibition/magazine"
  end
  
  def magazine_show
    @post = Post.find(params[:id])
  end
  
  def liked_magazine
  end
  
  def liked_magazine_toggle
    like = Magazine.find_by(user_id: current_user.id, post_id: params[:post_id])
    if like.nil?
      Magazine.create(user_id: current_user.id, post_id: params[:post_id])
    else
      like.destroy
    end
    redirect_to :back
  end
  
end