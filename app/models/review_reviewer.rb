class ReviewReviewer < ActiveRecord::Base
  attr_accessible :review_id, :user_id, :relationship
  
  belongs_to :user
  belongs_to :review
end
