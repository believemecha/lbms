class AddContentJsonToBlogs < ActiveRecord::Migration[7.0]
  def change
    add_column :blogs, :content_json, :jsonb, default: {}
  end
end
