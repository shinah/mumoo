class Exhibition < ActiveRecord::Base
  belongs_to :user
  has_many :likes
  has_many :replies
  has_many :liked_users, through: :likes, source: :user
  def start_time
      self.dateStart
  end
  
  def self.search(search)
      where("title LIKE ? or location LIKE ?", "%#{search}%", "%#{search}%")
  end
  
  is_impressionable :counter_cache => true
end
