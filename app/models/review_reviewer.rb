class ReviewReviewer < ActiveRecord::Base
  attr_accessible :review_id, :person_id, :relationship, :reviewer_attributes
  
  belongs_to :review
  belongs_to :reviewer, :class_name=>"Person", :foreign_key=>"person_id",:dependent=>:destroy
  
  accepts_nested_attributes_for :reviewer, :allow_destroy=>true
  
  validates_associated :reviewer
  
  
  validates_uniqueness_of :person_id, :scope => :review_id, :message => "The same person cannot be reinvited" 
  
  validates_presence_of :relationship

  # This can happen if you fail to create a valid person, then associate that
  # record in a review_reviewer row 
  validates_presence_of :person_id, message: "is required to be associated with a review"
  
  validates_presence_of :review_id, message: "is required to be associated with a reviewer"
  
end
