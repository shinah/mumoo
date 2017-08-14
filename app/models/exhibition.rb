class Exhibition < ActiveRecord::Base
  belongs_to :user
  has_many :likes
  has_many :replies
  has_many :liked_users, through: :likes, source: :user
  has_and_belongs_to_many :tags
  def start_time
      self.dateStart
  end
  
  def self.search(search)
      where("title LIKE ? or location LIKE ? or hashtag LIKE ? ", "%#{search}%", "%#{search}%","%#{search}")
  end
  
  is_impressionable :counter_cache => true

    after_create do
        post = Exhibition.find_by(id: self.id)
        hashtags = self.hashtag.scan(/#[ㄱ-ㅎ가-힣0-9a-zA-Z]+/)
        hashtags.uniq.map do |hashtag|
            tag = Tag.find_or_create_by(tagname: hashtag.downcase.delete('#'))
            post.tags << tag
        end
    end
    
    before_update do
        post = Exhibition.find_by(id: self.id)
        post.tags.clear
        hashtags = self.hashtag.scan(/#[ㄱ-ㅎ가-힣0-9a-zA-Z]+/)
        hashtags.uniq.map do |hashtag|
            tag = Tag.find_or_create_by(tagname: hashtag.downcase.delete('#'))
            post.tags << tag
        end
    end
end
