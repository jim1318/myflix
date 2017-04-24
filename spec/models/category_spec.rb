require 'spec_helper'

describe Category do
  it "saves itself" do
    category = Category.new(name: "Chick Flick")
    category.save
    expect(Category.first).to eq(category)
  end

  it "has many videos" do
    category = Category.create(name: "Chick Flick")
    video1 = Video.create(category: category, title: "Family Guysss", description: "Very funny show Family Guy Is")
    video2 = Video.create(category: category, title: "Family Dogs", description: "Show about dogs")
    expect(category.videos).to include(video2, video1)
  end

  describe "#recent_videos" do

    it "returns the videos in reverse chronologica order by created_at" do
      category = Category.create(name: "Chick Flick")
      video1 = Video.create(category: category, title: "Family Guysss", description: "Very funny show Family Guy Is")
      video2 = Video.create(category: category, title: "Family Dogs", description: "Show about dogs", created_at: 1.day.ago)
      expect(category.recent_videos).to eq([video1, video2])
    end
    
    it "returns an empty array when there are no videos" do
      category = Category.create(name: "Chick Flick")
      videos = category.recent_videos
      expect(category.recent_videos).to eq([])
    end

    it "returns all videos when ther are 6 or fewer" do
      category = Category.create(name: "Chick Flick")
      video1 = Video.create(category: category, title: "Family Guysss", description: "Very funny show Family Guy Is")
      video2 = Video.create(category: category, title: "Family Dogs", description: "Show about dogs")
      expect(category.recent_videos).to eq([video2, video1])
    end

    it "returns 6 most recent videos when there are greater than 6" do
      category = Category.create(name: "Chick Flick")
      7.times { Video.create(category: category, title: "V1", description: "Very funny show Family Guy Is") }
      expect(category.recent_videos.count).to eq(6)
    end

    it "returns the most recent 6 videos" do 
      category = Category.create(name: "Chick Flick")
      video2 = Video.create(created_at: 1.day.ago, category: category, title: "Family Dogs", description: "Show about dogs")
      12.times { Video.create(category: category, title: "V1", description: "Very funny show Family Guy Is") }
      expect(category.recent_videos).not_to include(video2)
    end

  end



end