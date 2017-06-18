require 'spec_helper'

feature 'User invites friend' do
  scenario "User successfully invites friend and invitation is accepted", { js: true, vcr: { record: :all } } do
    alice = Fabricate(:user)
    sign_in(alice)

    invite_a_friend
    friend_accepts_invitation
    friend_signs_in
    friend_should_follow(alice)
    inviter_should_follow_friend(alice)

    clear_email
  end

  def invite_a_friend
    visit new_invitation_path
    fill_in "Friend's Name", with: "John Doe"
    fill_in "Friend's Email", with: "john@example.com"
    fill_in "Message", with: "Hello - please join"
    click_button "Send Invitation"
    sign_out
  end

  def friend_accepts_invitation
    open_email "john@example.com"
    current_email.click_link "Accept this invitation"
    fill_in "Password", with: "password"
    fill_in "Full Name", with: "John Doe"

    within_frame(find('iframe')) do  
      fill_in name: 'cardnumber', with: "4242424242424242"
      fill_in name: 'exp-date', with: '11/20'
      fill_in name: 'cvc', with: '123'
      fill_in name: 'postal', with: '90210'
    end
    click_button "Submit Payment"
    sleep 5
  end

  def friend_signs_in
    fill_in "Email Address", with: "john@example.com"
    fill_in "Password", with: "password"
    click_button "Sign In"
    sleep 5
  end

  def friend_should_follow(user)
    click_link "People"
    expect(page).to have_content user.full_name
  end

  def inviter_should_follow_friend(inviter)
    sign_in(inviter)
    click_link "People"
    expect(page).to have_content "John Doe"
  end

end