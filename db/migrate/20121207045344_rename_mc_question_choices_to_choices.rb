class RenameMcQuestionChoicesToChoices < ActiveRecord::Migration
  def change
    rename_table :mc_question_choices, :choices
  end
end
