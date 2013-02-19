class RenameOrderInQuestions < ActiveRecord::Migration
  def change
    rename_column :questions, :order, :question_order  
  end
end
