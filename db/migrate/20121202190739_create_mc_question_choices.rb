class CreateMcQuestionChoices < ActiveRecord::Migration
  def change
    create_table :mc_question_choices do |t|
      t.integer :question_id, null: false
      t.string :type
      t.integer :choice_number, null: false
      t.string :choice_text
      t.integer :choice_range_number

      t.timestamps
    end
  end
end
