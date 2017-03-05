class Booking < ApplicationRecord
  belongs_to :fb_user, optional: true
end
