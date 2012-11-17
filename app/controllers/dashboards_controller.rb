class DashboardsController < ApplicationController
  before_filter :signed_in_user, only: [:show]
  before_filter :correct_user, only: [:show]
  
  def show
    @user = User.find(params[:id])
    @reviews_of_me = @user.reviews_of_me
    @reviews_of_others = @user.reviews_of_others
    
    @breadcrumb = [
        {text: "Dashboard"}
      ]
  end
end
