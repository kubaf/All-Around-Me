class ReviewersController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_review, only: [:edit, :update, :create]
  
  def index
    @review = Review.find(params[:review_id])
    @invited_review_reviewer = ReviewReviewer.new
    @invited_reviewer = Person.new
  end
  
  def create
    @review = Review.find(params[:review_id])
    
    @person = Person.find_by_email(params[:person][:email])
    if @person.blank?
      @person = Person.create(:email=>params[:person][:email])
    end
    
    @review.review_reviewers.build(:person_id => @person.id, 
                                    :review_id => @review.id, 
                                    :relationship=>params[:review_reviewer][:relationship])
    pp env
    
    pp @review.review_reviewers
    
    if @review.save
      respond_to do |format|
        format.html { redirect_to review_reviewers_path(@review), flash: {success: 'Reviewer ivited!'}}
      end
    else
      respond_to do |format|
        format.html { redirect_to review_reviewers_path(@review) }
      end
    end
    
      
  end
  

  
end
