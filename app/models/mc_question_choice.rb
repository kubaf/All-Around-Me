class McQuestionChoice < ActiveRecord::Base
  attr_accessible :choice_number, :choice_range_number, :choice_text, :question_id, :type
  
  belongs_to :mc_question
  
end
