class Response < ActiveRecord::Base
  attr_accessible :mc_question_choice_id, :response_text, :type
  
  has_many :reviews
end
