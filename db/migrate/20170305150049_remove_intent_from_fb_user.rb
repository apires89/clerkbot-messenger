class RemoveIntentFromFbUser < ActiveRecord::Migration[5.0]
  def change
    remove_reference :fb_users, :intent, foreign_key: true
  end
end
