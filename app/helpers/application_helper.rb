module ApplicationHelper
  def options_for_video_reviews(selected=nil)
    options = {}
    (1..5).each { |num| options[pluralize(num, "Star")] = num }
    options_for_select(options, selected)
  end
end
