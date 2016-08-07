# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(username: 'marc', password: 'password')

def sub_info(index)
  case index
  when 1
    { title: Faker::Pokemon.name, description: Faker::Pokemon.location }
  when 2
    { title: Faker::StarWars.character, description: Faker::StarWars.quote }
  when 3
    { title: Faker::Superhero.name, description: Faker::Superhero.power }
  when 4
    { title: Faker::Book.title, description: Faker::Hipster.sentence }
  end
end

50.times do |user_id|

  sub_data = sub_info(rand(1..4))

  User.create!(
    username: Faker::Internet.user_name,
    password: 'password'
    )

  Sub.create!(
    title: sub_data[:title],
    description: sub_data[:description],
    user_id: user_id
    )
end

100.times do
  index = rand(1..4)
  Post.create!(
    title: Faker::Hipster.sentence,
    content: Faker::Hipster.paragraphs,
    url: Faker::Internet.url,
    user_id: rand(1..50),
    sub_ids: Array.new(rand(1..50)){ rand(1..50) }.uniq
    )
end

100.times do |post_id|
  #parent comments
  (rand(1..10)).times do
    Comment.create!(
      content: Faker::Hipster.sentence,
      user_id: rand(1..50),
      post_id: post_id,
      comment_id: nil
    )
    #nested comments
    (rand(1..10)).times do
      Comment.create!(
          content: Faker::Hipster.sentence,
          user_id: rand(1..50),
          post_id: post_id,
          comment_id: Comment.last.id
        )
    end
  end
end
