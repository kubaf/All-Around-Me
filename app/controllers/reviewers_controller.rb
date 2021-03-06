class ReviewersController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_review, only: [:edit, :update, :create]
  
  def edit
    @review = Review.find(params[:id])
    @review.reviewers.build
    @review.review_reviewers.build
    
    @breadcrumb = [
        {link: review_path(@review), text: @review.name},
        {text: "Edit Reviewers"}
      ]
  end
  
  def create
    @review = Review.find(params[:review_id])
    
    # This will pull back either a Person or a User object depending on type attribute
    @reviewer = Person.find_by_email(params[:review_reviewer][:reviewer_attributes][:email])
    
    if @reviewer.nil?
      @reviewer = Person.create(params[:review_reviewer][:reviewer_attributes])
    end
        
    @review_reviewer = ReviewReviewer.create(review_id: @review.id, person_id: @reviewer.id, relationship: params[:review_reviewer][:relationship])
    
    # I'm not sure why we need this here: @review.save!
    
    @breadcrumb = [
      {link: review_path(@review), text: "Review: #{@review.name}"},
      {link: review_reviewers_path(@review), text: "Reviewers"},
      {text: "Add Reviewer"}
    ]
    
    if @review_reviewer.save
      respond_to do |format|
        format.html { redirect_to review_reviewers_path(@review), flash: {success: 'Reviewer invited!'}}
      end
    else
      respond_to do |format|
        format.html { render action: "new" }
      end
    end
  end
  
  def update
    render :index
  end
  
  def show
    render :index
  end
  
  def index
    @review = Review.find(params[:review_id])
    
    @breadcrumb = [
        {link: review_path(@review), text: @review.name},
        {text: "Reviewers"}
      ]
  end
  
  def new  
    @review = Review.find(params[:review_id])  
    @review_reviewer = ReviewReviewer.new
    
    @breadcrumb = [
      {link: review_path(@review), text: "Review: #{@review.name}"},
      {link: review_reviewers_path(@review), text: "Reviewers"},
      {text: "Add Reviewer"}
    ]
  end
  
  
  
  def update
    @review = Review.find(params[:id])
    @invited_review_reviewer = ReviewReviewer.new
    
    # first figure out if person exists
    @person = Person.find_by_email(params[:person][:email])
    if @person.blank?
      
      @invited_reviewer = Person.new(:email=>params[:person][:email])
      @invited_review_reviewer = ReviewReviewer.new(@invited_reviewer.id,params[:review_reviewer])
      if @invited_reviewer.valid? && @invited_review_reviewer.valid?
        redirect_to review_reviewers_path(@review)
      else
        pp env
        flash.now[:error] = 'There was an error with the form below!'
        render action: :index
        return
      end
    end
    

    
    pp flash
    
    
    if @reviewer.save
      
      
      # Reviewer doesn't exist for this review so they can be invited
      if @reviewer.blank?
      
        @review_reviewer = @review.review_reviewers.build(:person_id => @person.id, 
                                    :review_id => @review.id, 
                                    :relationship=>params[:review_reviewer][:relationship])
        if @review.save
          respond_to do |format|
            format.html { redirect_to review_reviewers_path(@review), flash: {success: 'Reviewer invited!'}}
          end
        else
          respond_to do |format|
            format.html { redirect_to review_reviewers_path(@review), flash: {error: 'An error occurred inviting the reviewer!'} }
          end
        end
      
      # Reviewer exists for this review so cannot be invited
      else
        respond_to do |format|
          format.html { 
            redirect_to review_reviewers_path(@review), 
            flash: {notice: 'This reviewer has already been invited'} }
        end
      end
    
    # Error occurred saving person
    else
      respond_to do |format|
        format.html { 
          render action: :edit
          #redirect_to review_reviewers_path(@review), 
          #flash: {error: 'An error occurred inviting the reviewer!'} 
          }
      end
    end
      
  end
  

  
end
