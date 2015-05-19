require 'faker'

#Create Users
5.times do
  user = User.new(
    name:     Faker::Name.name,
    email:    Faker::Internet.email,
    password: Faker::Lorem.characters(10)
  )

  user.skip_confirmation!
  user.save!
end
users = User.all

#Create topics
15.times do
  Topic.create!(
      name: Faker::Lorem.sentence,
      description: Faker::Lorem.paragraph
  )
end
topics = Topic.all

#Create posts
50.times do
  Post.create!(
    user: users.sample,
    topic: topics.sample,
    title: Faker::Lorem.sentence,
    body:  Faker::Lorem.paragraph
  )
end
posts = Post.all

#Create Comments
100.times do
  Comment.create!(
    post: posts.sample,
    body: Faker::Lorem.paragraph
  )
end

#Add Admin
admin = User.new(
  name: "Admin User",
  email: "admin@bloccit.com",
  password: "password",
  role: "admin"
)
admin.skip_confirmation!
admin.save!

#Add Moderator
moderator = User.new(
  name: "Moderator User",
  email: "moderator@bloccit.com",
  password: "password",
  role: "moderator"
)
moderator.skip_confirmation!
moderator.save!

#Add Member
member = User.new(
  name: "Normal User",
  email: "user@bloccit.com",
  password: "password"
)
member.skip_confirmation!
member.save!

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
