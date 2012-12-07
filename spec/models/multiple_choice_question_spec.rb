require 'spec_helper'

describe Multiple_Choice_Question do
  
  before(:each) do
    @attr = {
      question_text: "Why did the chicken cross the road?",
      order: 1
    }
    @choice = {
      choice_number: 1,
      choice_text: "To get to the other side"
    }
    
    
    @question = Multiple_Choice_Question.new(@attr)
    @question.choices.build(@choice)
    @question.save!
  end
  
  subject {@question}
  
  it {should respond_to(:type)}
  it {should respond_to(:question_text)}
  it {should respond_to(:order)}
  it {should respond_to(:min_valid_choices)}
  it {should respond_to(:max_valid_choices)}
  
  it {should be_valid}
  
  describe "type" do
    it "should be a Multiple_Choice_Question" do
      @question.type.should == @question.class.name
    end
  end
  
  describe "max_valid_choices_must_be_greater_than_min_valid_choices" do
    before {@question.min_valid_choices=999}
    before {@question.max_valid_choices=1}
    it {should_not be_valid}
  end
  
  
  describe "question text" do
    describe "when empty" do
      before { @attr[:question_text] = ""}
      before { @question = Question.new(@attr)}
      it {should_not be_valid}
    end  
  end
  
  describe "order" do
    describe "must be unique" do
      before { @question = Question.new(@attr)}
      it {should_not be_valid}
    end
  end

end
