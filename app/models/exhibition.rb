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
  
  has_many :impressions, :as=>:impressionable
  is_impressionable
  # def impression_count
  #     impressions.size
  # end
   
  # def unique_impression_count
  #     # impressions.group(:ip_address).size gives => {'127.0.0.1'=>9, '0.0.0.0'=>1}
  #     # so getting keys from the hash and calculating the number of keys
  #     impressions.group(:ip_address).size.keys.length #TESTED
  # end

    
end
