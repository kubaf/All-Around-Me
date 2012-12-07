class Multiple_Choice_Question < Question
  
  attr_accessible :max_valid_choices, :min_valid_choices
  
  has_many :choices, :foreign_key=>"question_id", dependent: :destroy
  
  accepts_nested_attributes_for :choices, :allow_destroy => true
  
  validates_presence_of :max_valid_choices, :min_valid_choices
  
  validate :max_valid_choices_must_be_greater_than_min_valid_choices
  
  validates :choices, length: {minimum: 1}
  
  def max_valid_choices_must_be_greater_than_min_valid_choices
    if max_valid_choices < min_valid_choices
      errors.add(:max_valid_choices, "must be greater than minimum valid choices")
    end
  end
  
  def must_have_at_least_one_choice
    unless choices.count > 0
      errors.add(:choices, "must have at least one choice")
    end
  end
  
end