class AddCodeToGptPrompts < ActiveRecord::Migration[7.0]
  def change
    add_column :gpt_prompts, :code, :string
  end
end
