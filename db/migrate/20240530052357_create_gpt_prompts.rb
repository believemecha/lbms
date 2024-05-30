class CreateGptPrompts < ActiveRecord::Migration[7.0]
  def change
    create_table :gpt_prompts do |t|
      t.string :prompt
      t.timestamps
    end
  end
end
