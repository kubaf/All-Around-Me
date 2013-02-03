class Question < ActiveRecord::Base
  attr_accessible :order, :question_text, :type
  
  validates_presence_of :question_text
  validates_uniqueness_of :order
end
