class CreateGptPromptResponses < ActiveRecord::Migration[7.0]
  def change
    create_table :gpt_prompt_responses do |t|
      t.integer :gpt_prompt_id
      t.string :prompt
      t.string :response
      t.json :meta, default: {}
      t.timestamps
    end
  end
end
