# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  status     :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status_dt  :datetime
#  duration   :integer
#

require 'spec_helper'

describe Review do
  let(:user) {Factory.create(:user)}
  let!(:review) {Factory.create(:review, user: user)}


  
  subject {review}
  
  it {should respond_to(:name)}
  it {should respond_to(:status)}
  it {should respond_to(:status_dt)}
  it {should respond_to(:duration)}
  it {should respond_to(:user)}
  its(:user) {should == user}
  
  it {should be_valid}
  
  describe "when user_id is not present" do
    before {review.user_id = nil}
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
