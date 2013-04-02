class CreateReviewUserResponseSets < ActiveRecord::Migration
  def change
    create_table :review_user_response_sets do |t|
      t.integer :review_id
      t.integer :person_id
      t.datetime :started_at
      t.datetime :completed_at

      t.timestamps
    end
  end
end
