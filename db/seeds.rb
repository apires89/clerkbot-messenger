Booking.destroy_all
FbUser.destroy_all
Intent.destroy_all
Hostel.destroy_all
Room.destroy_all

# ------------------ Create property -----------------

moonhill_hostel = Hostel.new({
                      name:         "Moonhill Hostel",
                      description:  "When the tours, the adventure, the sports or the beach are over, you'll find the Moon Hill Hostel, created to be a continuation of your experiences in Sintra.
In an environment inspired by the traditions of the region were added modern touches to provide the exchange of experiences, socializing, comfort and simplicity that you will find as unforgettable as the rest of your trip.
The Moon Hill is your home away from home!",
                      address:      "Rua Guilherme Gomes Fernandes 17, Sintra, Portugal",
                      information:  "http://www.moonhillhostel.com/"
  })
moonhill_hostel.save!


suite = Room.new({
                      name:         "Suite",
                      description:  "Rooms with an excellent view, with all the comfort to take a rest from the busy day.",
                      capacity:      2
  })
suite.hostel = moonhill_hostel
suite.save!
suite.photo_url = "http://moonhillhostel.com/img/rooms/suite/main.jpg"
suite.save!

double_room = Room.new({
                      name:         "Double Room",
                      description:  "Room for two people, with a shared bathroom right in front, and, of course, the view of the Sintra Palace.",
                      capacity:     2
  })
double_room.hostel = moonhill_hostel
double_room.save!
double_room.photo_url = "http://moonhillhostel.com/img/rooms/double/main.jpg"
double_room.save!

dorm = Room.new({
                      name:         "Dorm",
                      description:  "Shared rooms, shared experiences. The room to know more people, with an excellent view of both the Palace and the Castle.",
                      capacity:     4
  })
dorm.hostel = moonhill_hostel
dorm.save!
dorm.photo_url = "http://moonhillhostel.com/img/rooms/dorms/main.jpg"
dorm.save!

family_room = Room.new({
                      name:         "Family Room",
                      description:  "The perfect room for a couple with two children, a double bed and a bunkbed make the perfect combination, with a small private patio.",
                      capacity:     4
  })
family_room.hostel = moonhill_hostel
family_room.save!
family_room.photo_url = "http://moonhillhostel.com/img/rooms/family/main.jpg"
family_room.save!

available_rooms = [suite, double_room, family_room, dorm]



#Create flow of conversation

answer = SimpleAnswer.new(message: "Good to see you! :) I can give you information about our Services, the city of Sintra or help you Book a night @ Moonhill!\n\n (Remember you can always type **home** to receive this message again!)")
answer.save!
top = Intent.new(q_string: "Home", q_key: 'root')
top.answer = answer
top.save!


# Booking

  answer = SimpleAnswer.new(message: "To look for availible rooms we need some information from you, if you want to exit booking you can at any time click exit.")
  answer.save!
  booking_intent = BookingStartIntent.new(q_string: "Book Now!", q_key: 'booking')
  booking_intent.parent_intent = top
  booking_intent.answer = answer
  booking_intent.save!

    answer = NoReplyAnswer.new(message: "When are you checking in? (dd mm yyyy)")
    answer.save!
    checkin_intent = BookingDateIntent.new(q_string: "Continue", q_key: 'booking_start_date', field: 'checkin')
    checkin_intent.parent_intent = booking_intent
    checkin_intent.answer = answer
    checkin_intent.save!

    answer = NoReplyAnswer.new(message: "When are you leaving? (dd mm yyyy)")
    answer.save!
    checkout_intent = BookingDateIntent.new(q_string: "Continue", q_key: 'booking_end_date', field: 'checkout')
    checkout_intent.parent_intent = checkin_intent
    checkout_intent.answer = answer
    checkout_intent.save!

    answer = CarouselAnswer.new(message: "Please choose one of our cozy rooms!")
    answer.save!
    room_intent = Intent.new(q_string: "Available Rooms", q_key: 'available_rooms')
    room_intent.parent_intent = checkout_intent
    room_intent.answer = answer
    room_intent.save!

      answer = RoomCarouselAnswer.new(available_rooms)
      answer.save!
      pickroom_itent = Intent.new(q_string: "#{room.name}", q_key: "room#{room.id}")
      pickroom_itent.parent_intent = room_intent
      pickroom_itent.answer = answer
      pickroom_itent.save!


# Where to eat

answer = SimpleAnswer.new(message: "Would you like to know the services we have for you?")
answer.save!
services_intent = Intent.new(q_string: "Services", q_key: 'services')
services_intent.parent_intent = top
services_intent.answer = answer
services_intent.save!

answer = ComplexAnswer.new(message: "Would you like to know the services we have for you?")
answer.save!
services_intent = Intent.new(q_string: "Services", q_key: 'services')
services_intent.parent_intent = top
services_intent.answer = answer
services_intent.save!

    # answer = ComplexAnswer.new(message: "Here is the full list of available services.")
    # answer.save!
    # intent = Intent.new(q_string: "List", q_key: "all")
    # intent.parent_intent = services_intent
    # intent.answer = answer
    # intent.save!

    answer = SimpleAnswer.new(message: "Check-In: from 1PM.")
    answer.save!
    intent = Intent.new(q_string: "Check In", q_key: 'check_in')
    intent.parent_intent = services_intent
    intent.answer = answer
    intent.save!

    answer = SimpleAnswer.new(message: "Check-Out: until 11AM.")
    answer.save!
    intent = Intent.new(q_string: "Check Out", q_key: "check_out")
    intent.parent_intent = services_intent
    intent.answer = answer
    intent.save!

    answer = SimpleAnswer.new(message: "24 hour working reception.")
    answer.save!
    intent = Intent.new(q_string: "Reseption", q_key: "reseption")
    intent.parent_intent = services_intent
    intent.answer = answer
    intent.save!

    answer = SimpleAnswer.new(message: "Breakfast included in the rate, from 7AM to 11AM.")
    answer.save!
    intent = Intent.new(q_string: "Breakfast", q_key: "breakfast")
    intent.parent_intent = services_intent
    intent.answer = answer
    intent.save!



    answer = SimpleAnswer.new(message: "Here are our complementary services:\n\nWi-fi\nKeycard room access\nAir Conditioning\nStorage lockers\nCraddle for infants.\n")
    answer.save!
    intent = Intent.new(q_string: "Complementary", q_key: "complementary")
    intent.parent_intent = services_intent
    intent.answer = answer
    intent.save!



    answer = SimpleAnswer.new(message: "Here are our entertainement services:\n\nBoard Games\nCable Tv\nBooks\nDVD\nPlaystation\n")
    answer.save!
    intent = Intent.new(q_string: "Entertainement", q_key: "entertainement")
    intent.parent_intent = services_intent
    intent.answer = answer
    intent.save!




    answer = SimpleAnswer.new(message: "We also have Towels,Hair-dryers and Plug-adapters available for a small fee :)")
    answer.save!
    intent = Intent.new(q_string: "Rent", q_key: "rent")
    intent.parent_intent = services_intent
    intent.answer = answer
    intent.save!




answer = SimpleAnswer.new(message: "We have a restaurant in the hostel! Would you like to check other places?")
answer.save!
eat_intent = Intent.new(q_string: "Restaurants", q_key: 'restaurants')
eat_intent.parent_intent = top
eat_intent.answer = answer
eat_intent.save!
restaurant_names = ["Happy place", "Some place", "Old place"]
3.times do |i|
    answer = RestaurantAnswer.new(message: Faker::Lorem.paragraph,
      name: restaurant_names[i],
      url: "https://www.google.pt/"
      )
    answer.save!
    intent = Intent.new(q_string: restaurant_names[i], q_key: restaurant_names[i].delete(' ').downcase)
    intent.parent_intent = eat_intent
    intent.answer = answer
    intent.save!
end
################################################ ACTIVITIES AWNSER#################
answer = CarouselAnswer.new(message: "Here are our activities! I wish i could come along but im a bot.. :(")
answer.save!
info_intent = Intent.new(q_string: "Activities", q_key: 'activities')
info_intent.parent_intent = top
info_intent.answer = answer
info_intent.save!


  answer = CarouselItemAnswer.new(name: "Experience local gastronomy",
    photo: "http://res.cloudinary.com/dqltnr3rd/image/upload/c_scale,h_157,w_374/v1488901062/gastronomia-travesseiro_pt_icwcvb.jpg",
    title: "Try Queijadas and Travesseiros",
    subtitle: "Local Pastry",

    )
  answer.save!
  intent = Intent.new(q_string: "Gastronomy", q_key: "gastronomy")
  intent.parent_intent = info_intent
  intent.answer = answer
  intent.save!

answer = CarouselItemAnswer.new(name: "Take the tram to the beach",
    photo: "http://res.cloudinary.com/dqltnr3rd/image/upload/c_scale,w_457/v1488901365/tourist_train.jpg",
    title: "Sintra tram to Praia Grande",
    subtitle: "Iconic local tram",

    )
  answer.save!
  intent = Intent.new(q_string: "tram", q_key: "local_tram")
  intent.parent_intent = info_intent
  intent.answer = answer
  intent.save!

  answer = CarouselItemAnswer.new(name: "Surf around Sintra",
    photo: "http://res.cloudinary.com/dqltnr3rd/image/upload/v1488899268/surf_activity.jpg",
    title: "Surfing",
    subtitle: "Quality beach breaks at Praia Grande",
    )
  answer.save!
  intent = Intent.new(q_string: "Biking tour ", q_key: "biking_tour")
  intent.parent_intent = info_intent
  intent.answer = answer
  intent.save!

  answer = CarouselItemAnswer.new(name: "Pena National Park",
    photo: "http://res.cloudinary.com/dqltnr3rd/image/upload/v1488902411/national_park.jpg",
    title: "Visti Pena's beautiful national park",
    subtitle: "Amazing experience",

    )
  answer.save!
  intent = Intent.new(q_string: "National park", q_key: "national_park")
  intent.parent_intent = info_intent
  intent.answer = answer
  intent.save!

  #################################################################



answer = SimpleAnswer.new(message: "Select what u want to search for")
answer.save!
location_intent = Intent.new(q_string: "Near by places", q_key: 'places')
location_intent.parent_intent = top
location_intent.answer = answer
location_intent.save!

search_keys = ['museum', 'atm']

search_keys.each do |key|
  answer = GoogleApiCarouselAnswer.new(name: key, message: "Select to get details!")
  answer.save!
  google_intent = Intent.new(q_string: key.capitalize, q_key: "google_api_#{key}")
  google_intent.parent_intent = location_intent
  google_intent.answer = answer
  google_intent.save!
end


