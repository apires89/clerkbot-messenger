# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Intent.destroy_all

top = Intent.new(q_string: "root")
top.save!
answer = MiddleAnswer.new(name: "Root")
answer.intent = top
answer.save!
3.times do |i|
  child1 = Intent.new(q_string: "Child#{i}")
  child1.intent = top
  child1.save!
  answer1 = MiddleAnswer.new(name: "Level1Child#{i}Answer")
  answer1.intent = child1
  answer1.save!
  3.times do |j|
    child2 = Intent.new( q_string: "Child#{i}Child#{j}")
    child2.intent = child1
    child2.save!
    answer2 = MiddleAnswer.new(name: "Level2Child#{i}Child#{j}Answer")
    answer2.intent = child2
    answer2.save!
    3.times do |x|
      child3 = Intent.new(
          q_string: "Child#{i}Child#{j}Child#{x}"
        )
      child3.intent = child2
      child3.save!
      answer3 = FinalAnswer.new(
        name: Faker::StarWars.planet,
        message: Faker::StarWars.quote,
        photo: "https://www.yorkcountygov.com/_fileUploads/images/Slide23.JPG"
        )
      answer3.intent = child3
      answer3.save!
    end
  end
end
