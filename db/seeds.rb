# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(username: 'marc', password: 'password')

50.times do
  User.create!(
    username: Faker::Internet.user_name,
    password: 'password'
    )

  Sub.create!(
    title: Faker::Hipster.word.capitalize,
    description: Faker::Hipster.sentence,
    user_id: 1
    )
end

100.times do |i|
  Post.create!(
    title: Faker::Hipster.word.capitalize,
    content: Faker::Hipster.paragraphs(2).join("\n"),
    url: Faker::Internet.url,
    user_id: 1,
    sub_ids: Array.new(rand(1..50)){ rand(1..50) }.uniq
    )
end

100.times do |post_id|
  #parent comments
  (rand(1..10)).times do
    Comment.create!(
      content: Faker::Hipster.sentence,
      user_id: 1,
      post_id: post_id,
      comment_id: nil
    )
    #nested comments
    (rand(1..10)).times do
      Comment.create!(
          content: Faker::Hipster.sentence,
          user_id: 1,
          post_id: post_id,
          comment_id: Comment.last.id
        )
    end
  end
end
