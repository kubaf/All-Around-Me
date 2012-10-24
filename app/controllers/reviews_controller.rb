class ReviewsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_review, only: [:edit, :update]
  
  def create
    @review = current_user.reviews.build(params[:review])
    @review.update_status('pending')
    
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
    
    @breadcrumb = [
        {text: "Create Review"}
      ]
  end
  
  def edit
    @review = current_user.reviews.find(params[:id])
    
    @breadcrumb = [
        {text: @review.name}
      ]
  end
  
  def update
    respond_to do |format|
      if @review.update_attributes(params[:review])
        format.html { redirect_to dashboard_path(@current_user), flash: {success: 'Review changes saved!'} }
      else
        format.html { render action: "edit" }
      end
    end
  end
  
  
end
