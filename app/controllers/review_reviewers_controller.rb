class ReviewReviewersController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_review, only: [:show, :edit, :update]
  
  def show
    @review = Review.find(params[:id])
    @invited_review_reviewer = ReviewReviewer.new
    @invited_reviewer = Person.new
  end
  
  def create
    pp env
  end
  
end
