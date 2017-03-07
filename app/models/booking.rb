class Booking < ApplicationRecord
  belongs_to :fb_user, optional: true
  belongs_to :room, optional: true
end
