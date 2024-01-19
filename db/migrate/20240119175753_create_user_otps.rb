class CreateUserOtps < ActiveRecord::Migration[7.0]
  def change
    create_table :user_otps do |t|
      t.integer :user_id
      t.integer :purpose
      t.string :otp
      t.datetime :valid_till
      t.integer :status
      t.timestamps
    end
  end
end
