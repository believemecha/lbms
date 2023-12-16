class CreateRaiseAnIssues < ActiveRecord::Migration[7.0]
  def change
    create_table :raise_an_issues do |t|
      t.string :user_type
      t.references :user, foreign_key: true
      t.string :phone_number
      t.string :email_id
      t.string :subject
      t.string :description
      t.integer :status
      t.references :acted_by_user, foreign_key: { to_table: :users }
      t.text :adding_comments

      t.timestamps
    end
  end
end
