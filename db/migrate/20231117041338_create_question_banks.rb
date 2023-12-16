class CreateQuestionBanks < ActiveRecord::Migration[7.0]
  def change
    create_table :question_banks do |t|
      t.string :subject
      t.string :stream
      t.string :question
      t.date   :assigning_on
      t.integer :qualification
      t.integer :quiz_options
      t.string :solution
      t.string :correct_answer

      t.timestamps
    end
  end
end
