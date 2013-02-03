class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.string :type
      t.text :response_text
      t.integer :mc_question_choice_id

      t.timestamps
    end
  end
end
