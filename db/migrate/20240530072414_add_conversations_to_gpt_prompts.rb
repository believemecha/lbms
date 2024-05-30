class AddConversationsToGptPrompts < ActiveRecord::Migration[7.0]
  def change
    add_column :gpt_prompts, :conversations, :jsonb, default: []
  end
end
