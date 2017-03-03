class Intent < ApplicationRecord
  belongs_to :intent, optional: true
  has_many :intents, dependent: :nullify
  belongs_to :answer
end
