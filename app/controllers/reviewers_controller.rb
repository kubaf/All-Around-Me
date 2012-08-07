class ReviewersController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_review, only: [:edit, :update]
  
  def show
    @review = Review.find(params[:id])
  end
  
end
