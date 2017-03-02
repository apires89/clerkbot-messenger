# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Intent.destroy_all

top = Intent.new(q_string: "root", )
top.save!
answer = SimpleAnswer.new(message: "What about would you like to know?")
answer.intent = top
answer.save!

booking_intent = Intent.new(q_string: "Booking", q_key: 'booking')
booking_intent.intent = top
booking_intent.save!
answer = SimpleAnswer.new(message: "Book now! (pipeline starts)")
answer.intent = booking_intent
answer.save!



info_intent = Intent.new(q_string: "Info", q_key: 'info')
info_intent.intent = top
info_intent.save!
answer = SimpleAnswer.new(message: "What would you like to get more info?")
answer.intent = info_intent
answer.save!

intent = Intent.new(q_string: "Breakfast", q_key: 'breakfast')
intent.intent = info_intent
intent.save!
answer = SimpleAnswer.new(message: "We have world class breakfast included in room price! Located in dining hall, first floor from 8am to 11am")
answer.intent = intent
answer.save!

intent = Intent.new(q_string: "Bike rental", q_key: "bike_rental")
intent.intent = info_intent
intent.save!
answer = SimpleAnswer.new(message: "You can rent bikes for low low prices, 20 per day! Ask reseption")
answer.intent = intent
answer.save!

intent = Intent.new(q_string: "Laundry", q_key: "laundry")
intent.intent = info_intent
intent.save!
answer = SimpleAnswer.new(message: "Leave clothes in designaded laundry basket on bed")
answer.intent = intent
answer.save!





info_intent = Intent.new(q_string: "Activities", q_key: 'activities')
info_intent.intent = top
info_intent.save!
answer = CarouselAnswer.new(message: "Here are our activities?")
answer.intent = info_intent
answer.save!

4.times do |i|

  intent = Intent.new(q_string: "Biking tour #{i}", q_key: 'biking_tour#{i}')
  intent.intent = info_intent
  intent.save!
  answer = CarouselItemAnswer.new(name: "Biking tour",
    photo: "http://cdn.snowkingmountain.com/wp-content/uploads/2015/10/biking-miles-of-pathways-in-jackson-hole-1024x683.jpg",
    title: "Biking tour",
    subtitle: "Nice biking",

    )
  answer.intent = intent
  answer.save!
end

