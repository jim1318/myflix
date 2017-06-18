require 'spec_helper'

describe 'Admin adds new video' do
  scenario 'Admin successfully adds a new video' do
    admin = Fabricate(:admin)
    dramas = Fabricate(:category, name: "Dramas")
    sign_in(admin)
    visit new_admin_video_path

    fill_in "Title", with: "Monk"
    select "Dramas", from: "Category"
    fill_in "Description", with: "SF detective"
    attach_file "Large cover", "spec/support/uploads/bernie_small.jpg"
    attach_file "Small cover", "spec/support/uploads/bernie_small.jpg"
    fill_in "Video URL", with: "http://www.example.com/video.mp4"
    click_button "Add Video"

    sign_out
    sign_in

    visit video_path(Video.first)
    expect(page).to have_selector("img[src='/uploads/bernie_small.jpg']")
    expect(page).to have_selector("a[href='http://www.example.com/video.mp4']")
  end
end