class ReviewReviewer < ActiveRecord::Base
  attr_accessible :review_id, :person_id, :relationship, :reviewer_attributes
  
  belongs_to :review
  belongs_to :reviewer, :class_name=>"Person", :foreign_key=>"person_id",:dependent=>:destroy
  
  accepts_nested_attributes_for :reviewer, :allow_destroy=>true
  
  validates_associated :reviewer
  
  validates_uniqueness_of :person_id, :scope => :review_id, :message => "The same person cannot be reinvited" 
  
  validates_presence_of :relationship
  
  
end
