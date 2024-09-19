      class CreateTrackedEmails < ActiveRecord::Migration[7.0]
        def change
          create_table :tracked_emails do |t|
            t.string :token, null: false
            t.datetime :opened_at
            t.string :to_email
            t.string :mailer_class
            t.string :mailer_action
      
            t.timestamps
          end
        end
      end      
