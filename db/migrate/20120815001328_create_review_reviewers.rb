class CreateReviewReviewers < ActiveRecord::Migration
  def change
    create_table :review_reviewers do |t|
      t.integer :user_id
      t.integer :review_id
      t.string :relationship

      t.timestamps
    end
  end
end
