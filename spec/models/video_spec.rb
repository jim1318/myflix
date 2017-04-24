require 'spec_helper'

describe Video do
  it { should belong_to(:category)}
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:description)}

  describe "search_by_title" do

    it "returns an empty array if there is no match" do
      video1 = Video.create(title: "Family Guys", description: "Very funny show Family Guy Is")
      video2 = Video.create(title: "Family Dogs", description: "Show about dogs")
      expect(Video.search_by_title("Poetry")).to eq([])
    end

    it "returns an array or one video for an exact match" do
      video1 = Video.create(title: "Family Guys", description: "Very funny show Family Guy Is")
      video2 = Video.create(title: "Family Dogs", description: "Show about dogs")
      expect(Video.search_by_title("Family Guys")).to eq([video1])
    end

    it "returns an array of one video for a partial match" do
      video1 = Video.create(title: "Family Guys", description: "Very funny show Family Guy Is")
      video2 = Video.create(title: "Family Dogs", description: "Show about dogs")
      expect(Video.search_by_title("Guy")).to eq([video1])
    end
    
    it "returns an array of all matches ordered by created_at" do
      video1 = Video.create(title: "Family Guys", description: "Very funny show Family Guy Is")
      video2 = Video.create(title: "Family Dogs", description: "Show about dogs", created_at: 1.day.ago)
      expect(Video.search_by_title("Family")).to eq([video2, video1])
    end

    it "returns an empty array for a search term with an empty string" do
      video1 = Video.create(title: "Family Guys", description: "Very funny show Family Guy Is")
      video2 = Video.create(title: "Family Dogs", description: "Show about dogs", created_at: 1.day.ago)
      expect(Video.search_by_title("")).to eq([])
    end
  end

end