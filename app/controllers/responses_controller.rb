class ResponsesController < ApplicationController
  before_filter :signed_in_user
  
  def index
    @review = Review.find(params[:review_id])
    @questions = Question.all
    
    @questions.each do |question|
      response = ReviewQuestionResponse.where({review_id: @review.id, question_id: question.id})
      if response.empty?
        @review.review_question_responses.build ({question_id: question.id})
      end
    end
    
    @breadcrumb = [
      {link: review_path(@review), text: @review.name},
      {text: "Review"}
    ] 
  end
end
