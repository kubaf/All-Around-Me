class ReviewReviewer < ActiveRecord::Base
  attr_accessible :review_id, :person_id, :relationship
  
  validates :person_id, :uniqueness => {:scope => :review_id, :message => "The same person cannot be reinvited" }
  
  belongs_to :person
  belongs_to :review
end
