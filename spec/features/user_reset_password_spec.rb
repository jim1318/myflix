require 'spec_helper'

feature 'User going through full reset process' do
  scenario "user successfully reset" do
    alice = Fabricate(:user)
    clear_emails

    #Visit sign-in path and click on button to reset email
    visit sign_in_path
    click_link "Forgot Password?"
    
    #Fill out email address form and submit
    fill_in "email", with: alice.email
    click_button "Send Email"
    
    #OPen email and click on reset link
    open_email(alice.email)
    current_email.click_link "Reset My Password"

    #Enter new password and submit
    fill_in "password", with: 'new_password'
    alice.password = 'new_password'
    click_button "Reset Password"

    #Sign in using new password
    sign_in(alice)
    page.should have_content alice.full_name
  end
end