class ReviewReviewersController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_review, only: [:show, :edit, :update]
  
  
end
