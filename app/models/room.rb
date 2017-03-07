class Room < ApplicationRecord
  belongs_to :hostel
  has_attachment :photo
end
