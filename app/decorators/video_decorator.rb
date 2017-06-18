class VideoDecorator < Draper::Decorator
  delegate_all
  def rating
    object.average_rating == 0 ? "N/A" : "#{object.average_rating}/5.0"
  end
end