class AddPrevIntentToFbUser < ActiveRecord::Migration[5.0]
  def change
    add_reference :fb_users, :prev_intent
  end
end
