class McQuestionTextChoice < McQuestionChoice
  attr_accessible :choice_text
  
  validates_presence_of :choice_text
end