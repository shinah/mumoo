class Like < ActiveRecord::Base
  belongs_to :exhibition
  belongs_to :user
end
