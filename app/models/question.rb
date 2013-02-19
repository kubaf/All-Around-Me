class Question < ActiveRecord::Base
  attr_accessible :question_order, :question_text, :type
  
  validates_presence_of :question_text
  validates_uniqueness_of :question_order
  
  default_scope order('question_order ASC')
end
