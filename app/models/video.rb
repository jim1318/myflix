require 'elasticsearch/model'

class Video < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks     #Auto sync DB and Ealstic Serach records :)
  index_name ["myflix", Rails.env].join('_')
  #Video.import

  belongs_to :category
  has_many :reviews, -> { order "created_at DESC" }
  has_many :queue_items

  mount_uploader :large_cover, LargeCoverUploader
  mount_uploader :small_cover, SmallCoverUploader

  validates :title, presence: true
  validates :description, presence: true

  def self.search_by_title(title)
  return [] if title.blank?
    where(['LOWER(title) LIKE ?', "%#{title.downcase}%"]).order(created_at: :desc)
  end  

  def average_rating
    if self.reviews.count > 0
      avg_rating = (self.reviews.inject(0.0) { |sum, n| sum + n.rating } / self.reviews.count).to_f
    else
      0.0
    end
  end

  def as_indexed_json(options={})
    as_json(
      methods: [:average_rating],
      only: [:title, :description, :created_at],
      include: {
        reviews: { only: [:review_text]}
      }
    )
  end

  def self.search(query, options={})
    search_query = {
      query: {  
        bool: {
          must: {
            multi_match: {
              query: query,
              fields: ['title^100', 'description^50'],
              operator: 'and'
            }
          }
        }
      } 
    } 

    if query.present? && options[:reviews].present?
      search_query[:query][:bool][:must][:multi_match][:fields] << "reviews.review_text"
    end

    if options[:rating_from].present? || options[:rating_to].present?
      search_query[:query][:bool][:filter] = {
        range: {
          average_rating: {
            gte: (options[:rating_from].to_f if options[:rating_from].present?),
            lte: (options[:rating_to].to_f if options[:rating_to].present?)
          }
        }
      }
      binding.pry
    end

    __elasticsearch__.search(search_query)
  end

end