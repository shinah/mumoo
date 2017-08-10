class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  has_many :exhibitions
  has_many :likes
  has_many :liked_exhibitons, through: :likes, source: :exhibition
  def is_like?(exhibition)
    Like.find_by(user_id: self.id, exhibition_id: exhibition.id).present?
  end
  
  def self.find_for_oauth(auth, signed_in_resource = nil)
    identity = Identity.find_for_oauth(auth)
    user = signed_in_resource ? signed_in_resource : identity.user
 
    if user.nil?
      email = auth.info.email
      user = User.where(:email => email).first
      unless self.where(email: auth.info.email).exists?
        if user.nil?
          user = User.new(
            email: auth.info.email,
            profile_img: auth.info.image,
            password: Devise.friendly_token[0,20]
          )
          user.save!
        end
      end
    end
 
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end
 
  def email_required?
    false
  end  
end
