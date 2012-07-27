class ReviewsController < ApplicationController
  before_filter :signed_in_user
  
  def create
    @review = current_user.reviews.build(params[:review])
    @review.update_status('pending')
pp @review
    
    if @review.save
      respond_to do |format|
        format.html { redirect_to dashboard_path(current_user), flash: {success: 'Review created!'}}
      end
    else
      respond_to do |format|
        format.html { render action: "new" }
      end
    end
  end
  
  def new
    @review = Review.new
  end
  
  def edit
  end
  
  
end
