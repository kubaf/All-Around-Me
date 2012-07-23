require 'spec_helper'

describe Review do
  
  let(:user) {Factory.create(:user)}
  
  before(:each) do
    @attr = {
      :name => "Review Name 1", 
      :status => "active",
      }
    @review = user.reviews.build(@attr)
  end
  
  subject {@review}
  
  it {should respond_to(:name)}
  it {should respond_to(:status)}
  it {should respond_to(:user)}
  its(:user) {should == user}
  
  it {should be_valid}
  
  describe "when user_id is not present" do
    before {@review.user_id = nil}
    it {should_not be_valid}
  end
  
  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Review.new(user_id: user.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
  
end
