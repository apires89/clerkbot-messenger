class Intent < ApplicationRecord
  include PgSearch
  pg_search_scope :search, against: :q_string, using: {tsearch: {prefix: true, dictionary: "english"}}
  validates :q_string, presence: true
  validates :q_key, presence: true, uniqueness: true
  belongs_to :parent_intent, class_name: 'Intent', foreign_key: "intent_id", optional: true
  has_many :child_intents, class_name: 'Intent', foreign_key: "intent_id", dependent: :nullify
  belongs_to :answer


end
