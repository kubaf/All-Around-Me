class ChangeColumnsToNotNullInReviewReviewers < ActiveRecord::Migration
  def up
    change_column :review_reviewers, :person_id, :integer, null: false
    change_column :review_reviewers, :review_id, :integer, null: false
    change_column :review_reviewers, :relationship, :string, null: false
  end
  
  def down
    change_column :review_reviewers, :person_id, :integer, null: true
    change_column :review_reviewers, :review_id, :integer, null: true
    change_column :review_reviewers, :relationship, :string, null: true
  end
end
