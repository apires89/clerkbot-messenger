class Intent < ApplicationRecord
  belongs_to :parent_intent, class_name: 'Intent', foreign_key: "intent_id", optional: true
  has_many :child_intents, class_name: 'Intent', foreign_key: "intent_id", dependent: :nullify
  belongs_to :answer
end
