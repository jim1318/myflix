# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Video.create(title: "Family Guy", description: "Very funny show Family Guy Is", small_cover_url: "/tmp/family_guy.jpg", large_cover_url: "t/mp/family_guy.jpg", category_id: 1)
Video.create(title: "Futurama", description: "Very futuristic show Futurama Is", small_cover_url: "/tmp/futurama.jpg", large_cover_url: "/tmp/futurama.jpg", category_id: 2)
Video.create(title: "Monk", description: "Very wise show Monk Is", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", category_id: 3)
Video.create(title: "South Park", description: "Very dark show South Park Is", small_cover_url: "/tmp/south_park.jpg", large_cover_url: "/tmp/south_park.jpg", category_id: 1)
12.times { Video.create(title: "South Park", description: "Very dark show South Park Is", small_cover_url: "/tmp/south_park.jpg", large_cover_url: "/tmp/south_park.jpg", category_id: 1) }

Category.create(name: "Comedy")
Category.create(name: "Fantasy")
Category.create(name: "Thriller")
Category.create(name: "Murder")

User.create(email: "jim@gmail.com", password: "jimjim", full_name: "Jim Finnigan")
User.create(email: "bernie@gmail.com", password: "berniebernie", full_name: "Bernie Finnigan")