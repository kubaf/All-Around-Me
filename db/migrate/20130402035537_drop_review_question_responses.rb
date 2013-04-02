class DropReviewQuestionResponses < ActiveRecord::Migration
  def up
    drop_table :review_question_responses
  end

  def down
    create_table :review_question_responses do |t|
      t.integer :review_id, null: false
      t.integer :question_id, null: false
      t.integer :response_id, null: false

      t.timestamps
    end
    
    add_index :review_question_responses, [:review_id, :question_id, :response_id], unique: true, name: "review_question_responses_rev_q_resp_ids"
  end
end
