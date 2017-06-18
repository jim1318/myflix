# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Video.create(title: "Family Guy", description: "Very funny show Family Guy Is", small_cover: "/tmp/family_guy.jpg", large_cover: "t/mp/family_guy.jpg", category_id: 1)
Video.create(title: "Futurama", description: "Very futuristic show Futurama Is", small_cover: "/tmp/futurama.jpg", large_cover: "/tmp/futurama.jpg", category_id: 2)
Video.create(title: "Monk", description: "Very wise show Monk Is", small_cover: "/tmp/monk.jpg", large_cover: "/tmp/monk_large.jpg", category_id: 3)
Video.create(title: "South Park", description: "Very dark show South Park Is", small_cover: "/tmp/south_park.jpg", large_cover: "/tmp/south_park.jpg", category_id: 1)
12.times { Video.create(title: "South Park", description: "Very dark show South Park Is", small_cover: "/tmp/south_park.jpg", large_cover: "/tmp/south_park.jpg", category_id: 1) }

Category.create(name: "Comedy")
Category.create(name: "Fantasy")
Category.create(name: "Thriller")
Category.create(name: "Murder")

User.create(email: "jim@gmail.com", password: "jimjim", full_name: "Jim Finnigan")
User.create(email: "bernie@gmail.com", password: "berniebernie", full_name: "Bernie Finnigan")
User.create(Fabricate.attributes_for(:user))
User.create(Fabricate.attributes_for(:user))
User.create(Fabricate.attributes_for(:user))

Review.create(review_text: "This was a great movie", rating: 5, video_id: 1, user_id: 1)
Review.create(review_text: "This was an ok", rating: 3, video_id: 1, user_id: 1)
Review.create(review_text: "This was a pretty bad movide", rating: 2, video_id: 1, user_id: 1)

QueueItem.create(user_id: 1, video_id: 1, position: 1)
QueueItem.create(user_id: 1, video_id: 2, position: 2)
QueueItem.create(user_id: 1, video_id: 3, position: 3)

Relationship.create(follower_id: 1, leader_id: 2)
Relationship.create(follower_id: 1, leader_id: 3)
Relationship.create(follower_id: 1, leader_id: 4)