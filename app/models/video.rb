class Video < ActiveRecord::Base
  belongs_to :category
  has_many :reviews, -> { order "created_at DESC" }
  has_many :queue_items

  validates :title, presence: true
  validates :description, presence: true

  def self.search_by_title(search_term)
    return [] if search_term == ""
    where("title LIKE ?", "%#{search_term}%").order("created_at ASC")
  end  

  def average_rating
    if self.reviews.count > 0
      self.reviews.inject(0) { |sum, n| sum + n.rating } / self.reviews.count
    else
      0
    end
  end

end