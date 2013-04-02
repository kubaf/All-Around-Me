class ReviewQuestionResponse < ActiveRecord::Base
  attr_accessible :question_id, :response_id, :review_id
  
  belongs_to :review
  belongs_to :question
  belongs_to :response
  
  validates_uniqueness_of :review_id, :scope => [:question_id, :response_id], :message => "This response has already been provided" 
  
  validates_presence_of :review_id, message: "is required to be associated with a review"
  validates_presence_of :response_id, message: "is required to be associated with a response"
  validates_presence_of :question_id, message: "is required to be associated with a question"
end
