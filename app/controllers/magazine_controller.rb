class MagazineController < ApplicationController
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
    
    redirect_to "/magazine/magazine"
  end
  
  def magazine_edit
     @edit_post = Post.find(params[:id])
  end
  
  def magazine_update
    edit_post = Post.find(params[:id])
    edit_post.title = params[:title]
    edit_post.content = params[:content]
    edit_post.save
    
    redirect_to "/magazine/magazine"
  end
  
  def magazine_destroy
    destroy_post = Post.find(params[:id])
    destroy_post.destroy
    
    redirect_to "/magazine/magazine"
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
