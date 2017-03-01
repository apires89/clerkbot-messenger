class Intent < ApplicationRecord
  belongs_to :intent, optional: true
  has_many :intents, dependent: :nullify
  has_one :answer, dependent: :destroy
end
