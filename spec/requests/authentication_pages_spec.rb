require 'spec_helper'

describe "Authentication" do
  
  subject {page}
  
  describe "signin page" do
    before {visit signin_path}
    
    it {should have_selector('h1', text: 'Sign In')}
    it {should have_selector('title', text: 'Sign In')}
  end
  
  describe "signin" do
    before {visit signin_path}
    
    describe "with invalid information" do
      before {click_button "Sign in"}
      
      it {should have_selector('title', text: 'Sign In')}
      it {should have_selector('div.alert.alert-error', text: 'Invalid')}
      
      describe "after visiting another page" do
        before {click_link "Home"}
        it {should_not have_selector('div.alert.alert-error')}
      end
      
    end
    
    describe "with valid information" do
      let(:user) {Factory.create(:user)}
      before { sign_in user }
      
      it {should have_selector('title', text: user.name)}
      it {should have_link('Profile', href: edit_user_path(user))}
      it {should have_link('Sign out', href: signout_path)}
      it {should_not have_link('Sign in', href: signin_path)}
      
      describe "followed by a signout" do
        before {click_link "Sign out"}
        it {should have_link("Sign in")}
      end
    end
  end
  
  describe "authorization" do
    
    describe "for non-signed-in users" do
        let(:user) {Factory.create(:user)}
        
        describe "in the Users controller" do
          
          describe "visiting the edit page" do
            before {visit edit_user_path(user)}
            it {should have_selector('title', text: 'Sign In')}            
          end
          
          describe "submitting to the update action" do
            before {put user_path(user)}
            specify {response.should redirect_to(signin_path)}
          end
        end
    end
    
    describe "as wrong user" do
      let(:user) {Factory.create(:user)}
      let(:wrong_user) {Factory.create(:user, email: "wrong@email.com")}
      before {sign_in user}
      
      describe "visiting Users#edit page" do
        before {visit edit_user_path(wrong_user)}
        it {should_not have_selector('title', text: "Edit Profile")}
      end
      
      # I don't know how to make this test work
#      describe "submitting a put request to the Users#update action" do 
#        before do
#          sign_in user
#          visit edit_user_path(user)
#          put user_path(wrong_user)
#        end
#        specify {response.should redirect_to(root_path)}
#      end
    end
  end
end