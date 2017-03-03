class AddIntentToFbUser < ActiveRecord::Migration[5.0]
  def change
    add_reference :fb_users, :intent, foreign_key: true
  end
end
