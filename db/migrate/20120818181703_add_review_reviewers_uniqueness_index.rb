class AddReviewReviewersUniquenessIndex < ActiveRecord::Migration
  def change
    add_index :review_reviewers, [:review_id, :person_id], :unique => true
  end
end
