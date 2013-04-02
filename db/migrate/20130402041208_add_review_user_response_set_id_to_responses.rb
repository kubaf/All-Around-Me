class AddReviewUserResponseSetIdToResponses < ActiveRecord::Migration
  def change
    add_column :responses, :review_user_response_set_id, :integer
  end
end
