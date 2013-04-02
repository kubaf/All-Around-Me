class Response < ActiveRecord::Base
  attr_accessible :mc_question_choice_id, :response_text, :type
  
  belongs_to :review_user_response_set
  belongs_to :question
  belongs_to :choice
end
