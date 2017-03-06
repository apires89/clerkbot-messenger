class Room < ApplicationRecord
  belongs_to :hostel
  has_attachement :photo
end
