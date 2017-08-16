class Post < ActiveRecord::Base
   belongs_to :user
   has_many :magazines
   has_many :liked_users,through: :magazines, source: :user
end
