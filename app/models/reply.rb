class Reply < ActiveRecord::Base
   belongs_to :exhibition
   belongs_to :user
   ratyrate_rateable "star"
end
