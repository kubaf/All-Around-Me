require 'spec_helper'

describe "Dashboard Pages" do
  subject {page}

  let(:user) { Factory.create(:user) }
  let!(:r1) {Factory.create(:review, user: user, name: "review1")}
  let!(:r2) {Factory.create(:review, user: user, name: "review2")}
  
  
  describe "my reviews" do
    
    before do
      sign_in user
      visit dashboard_path(user)
    end
    
    it {should have_content(r1.name)}
    it {should have_content(r2.name)}
  end
  
end
