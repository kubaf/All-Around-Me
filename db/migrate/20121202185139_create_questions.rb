class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :type
      t.text :question_text, null: false
      t.integer :order
      t.integer :min_valid_choices, default: 1
      t.integer :max_valid_choices, default: 1

      t.timestamps
    end
  end
end
