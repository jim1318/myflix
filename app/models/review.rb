class Review < ActiveRecord::Base
  validates_presence_of :review_text, :rating, :user_id
  belongs_to :user
  belongs_to :video
end