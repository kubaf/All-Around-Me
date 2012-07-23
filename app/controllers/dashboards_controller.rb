class DashboardsController < ApplicationController
  before_filter :signed_in_user, only: [:show]
  before_filter :correct_user, only: [:show]
  
  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
  end
end
