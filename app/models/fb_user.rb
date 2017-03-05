class FbUser < ApplicationRecord
  belongs_to :prev_intent, class_name: 'Intent', foreign_key: "prev_intent_id", optional: true
  belongs_to :next_intent, class_name: 'Intent', foreign_key: "next_intent_id", optional: true
  has_one :booking
  validates :first_name, :last_name, :fb_id, presence: true
end
