require 'spec_helper'

describe Question do
  
  before(:each) do
    @attr = {
      question_text: "Why did the chicken cross the road?",
      order: 1
    }
    
    @question = Question.create!(@attr)
  end
  
  subject {@question}
  
  it {should respond_to(:type)}
  it {should respond_to(:question_text)}
  it {should respond_to(:order)}
  it {should respond_to(:min_valid_choices)}
  it {should respond_to(:max_valid_choices)}
  
  it {should be_valid}
  
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
