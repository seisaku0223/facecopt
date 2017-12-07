# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

20.times do |n|
  name = Faker::Name.name
  email = Faker::Internet.email
  password = "password"
  uid = SecureRandom.uuid
  user = User.create!(email: email,
               password: password,
               password_confirmation: password,
               name: name,
               uid: uid
              )
end

40.times do |m|
  topic_title = Yoshida::Text.word
  content = Yoshida::Text.sentence
  user_id = rand(1..20)
  topic = Topic.new

  topic = Topic.create!(
    topic: topic_title,
    content: content,
    user_id: user_id
  )
end

60.times do |o|
  user_id =  rand(1..20)
  topic_id = rand(1..30)
  content = Takarabako.open + "を手に入れた"
  comment = Comment.new

  comment = Comment.create!(
      user_id: user_id,
      topic_id: topic_id,
      content: content
  )
end
