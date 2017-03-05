class AddNextIntentToFbUser < ActiveRecord::Migration[5.0]
  def change
    add_reference :fb_users, :next_intent
  end
end
