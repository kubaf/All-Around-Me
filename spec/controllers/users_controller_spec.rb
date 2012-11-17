require 'spec_helper'

describe UsersController do
  render_views

  # This should return the minimal set of attributes required to create a valid
  # User. As you add validations to User, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {:first_name => "First", 
    :last_name => "Last", 
    :email => "user@example.com",
    :password => "foobar",
    :password_confirmation => "foobar"
    }
  end
  
  
# Fix this test with sign_in
#  describe "GET index" do
#    it "assigns all users as @users" do
#      user = User.create! valid_attributes
#      get :index
#      assigns(:users).should eq([user])
#    end
#  end

  describe "GET show" do
    
    before(:each) do
      @user = Factory(:user)
    end
    
    it "should be successful" do
      get :show, :id => @user
      response.should be_success
    end
    
    it "should find the right user" do
      get :show,:id => @user
      assigns(:user).should == @user
    end
    
    it "assigns the requested user as @user" do
      user = User.create! valid_attributes
      get :show, :id => user.id.to_s
      assigns(:user).should eq(user)
    end
    
  end

  describe "GET 'new'" do
    it "assigns a new user as @user" do
      get :new
      assigns(:user).should be_a_new(User)
    end
  end



  describe "POST create" do
    describe "with valid params" do
      it "creates a new User" do
        expect {
          post :create, :user => valid_attributes
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        post :create, :user => valid_attributes
        assigns(:user).should be_a(User)
        assigns(:user).should be_persisted
      end

      it "redirects to the created user's dashboard" do
        post :create, :user => valid_attributes
        response.should redirect_to(dashboard_url(User.last))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved user as @user" do
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        post :create, :user => {}
        assigns(:user).should be_a_new(User)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        post :create, :user => {}
        response.should render_template("new")
      end
    end
  end


#  describe "DELETE destroy" do
#    it "destroys the requested user" do
#      user = User.create! valid_attributes
#      user.toggle!(:admin)
#      expect {
#        delete :destroy, :id => user.id.to_s
#      }.to change(User, :count).by(-1)
#    end

#    it "redirects to the users list" do
#      user = User.create! valid_attributes
#      delete :destroy, :id => user.id.to_s
#      response.should redirect_to(users_url)
#    end
#  end

end
