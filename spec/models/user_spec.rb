require 'spec_helper'

describe User do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:full_name) }
  it { should validate_uniqueness_of(:full_name) }
  it { should have_many(:queue_items) }
  it { should have_many(:reviews).order("created_at DESC") } 

  it_behaves_like "tokenable" do
    let(:object) { Fabricate(:user) }
  end
  
  describe "#queued_video" do
    it "returns true when the user queued the video" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      Fabricate(:queue_item, user: user, video: video)
      expect(user.queued_video?(video)).to eq(true)
    end
    it "returns false when the user does not have the video in queue" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      expect(user.queued_video?(video)).to eq(false)
    end
  end

  describe "follows?" do
    it "returns true if the user has a following relationship with another user" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      Fabricate(:relationship, leader: bob, follower: alice)
      expect(alice.follows?(bob)).to eq(true)
    end

    it "reutrns false if hte user does not have a following relationship with another user" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      Fabricate(:relationship, leader: bob, follower: alice)
      expect(bob.follows?(alice)).to eq(false)
    end
  end

  describe "#follow" do
    it "follows another user" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      alice.follow(bob)
      expect(alice.follows?(bob)).to eq(true)
    end
    
    it "does not follow oneself" do
      alice = Fabricate(:user)
      alice.follow(alice)
      expect(alice.follows?(alice)).to eq(false)
    end
  end

  describe "Deactivate" do
    it "deactivates and active user" do
      alice = Fabricate(:user, active: true)
      alice.deactivate!
      expect(alice).not_to be_active
    end
  end
end