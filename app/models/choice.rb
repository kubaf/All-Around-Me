class Choice < ActiveRecord::Base
  attr_accessible :choice_number, :choice_range_number, :choice_text, :question_id, :type
  
  belongs_to :multiple_choice_question, :class_name=>"Question", :foreign_key=>"question_id"
  has_many :responses
  
  default_scope :order => "choice_number ASC"
  
end
