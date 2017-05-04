require 'spec_helper'

feature 'User interacts with Social Media' do
  scenario "users follows someone and then removes" do
    bob = Fabricate(:user)
    comedy = Fabricate(:category)
    monk = Fabricate(:video, category: comedy)
    review = Fabricate(:review, user: bob, video: monk)
    
    alice = Fabricate(:user)
    sign_in(alice)

    click_on_video_on_home_page(monk)
    click_link bob.full_name
    click_link "Follow"

    expect(page).to have_content(bob.full_name)

    unfollow(bob)
    expect(page).not_to have_content(bob.full_name)
  end

  def unfollow(user)
    find("a[data-method='delete']").click
  end
end