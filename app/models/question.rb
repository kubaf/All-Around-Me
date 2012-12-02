class Question < ActiveRecord::Base
  attr_accessible :max_valid_choices, :min_valid_choices, :order, :question_text, :type
  
  validates_presence_of :question_text
end
