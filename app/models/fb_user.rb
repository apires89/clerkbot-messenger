class FbUser < ApplicationRecord
  belongs_to :intent, optional: true
  validates :first_name, :last_name, :fb_id, presence: true
end
