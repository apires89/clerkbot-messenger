class FbUser < ApplicationRecord
  validates :first_name, :last_name, :fb_id, presence: true
end
