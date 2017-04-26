Fabricator(:review) do
  rating { (1..5).to_a.sample }
  review_text { Faker::Lorem.paragraph(3) }
end