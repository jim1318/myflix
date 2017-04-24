class Video < ActiveRecord::Base
  belongs_to :category

  validates :title, presence: true
  validates :description, presence: true


  def self.search_by_title(search_term)
    return [] if search_term == ""
    where("title LIKE ?", "%#{search_term}%").order("created_at ASC")
  end  
  



end