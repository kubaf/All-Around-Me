class RangeChoice < Choice
  attr_accessible :choice_range_number
  
  validates_numericality_of :choice_range_number
end