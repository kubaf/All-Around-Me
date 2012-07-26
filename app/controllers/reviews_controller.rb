class ReviewsController < ApplicationController
  before_filter :signed_in_user
  
  def create
    @review = current_user.reviews.build(params[:review])
    if @review.save
      format.html { redirect_to dashboard_path, flash: {success: 'Review created!'}}
    else
      format.html { render action: "new" }
    end
  end
  
  def new
    @review = Review.new
  end
  
  def edit
  end
  
  
end
