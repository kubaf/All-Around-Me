class ChangeUserIdToPersonIdInReviewReviewers < ActiveRecord::Migration
  def change
    rename_column :review_reviewers, :user_id, :person_id
  end
end
