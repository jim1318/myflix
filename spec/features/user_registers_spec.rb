require 'spec_helper'

feature 'User registers', { js: true, vcr: { record: :all } } do

  background do
    visit register_path
  end

  scenario 'with valid user info and valid card' do
    fill_in_valid_user_info
    fill_in_valid_card
    click_button "Submit Payment"
    sleep 2
    expect(page).to have_content("Thank you - Successfull Sign Up!")
  end

  scenario 'with valid user info and invalid card' do
    fill_in_valid_user_info
    fill_in_invalid_card
    click_button "Submit Payment"
    sleep 2
    expect(page).to have_content("Your card number is invalid.")
  end

  scenario 'with valid user info and declined card' do
    fill_in_valid_user_info
    fill_in_declined_card
    click_button "Submit Payment"
    sleep 2
    expect(page).to have_content("Your card was declined")
  end

  scenario 'with invalid user info and valid card' do
    fill_in_invalid_user_info
    fill_in_valid_card
    click_button "Submit Payment"
    sleep 2
    expect(page).to have_content("Please fix user errors")
  end
  
  scenario 'with invalid user info and invalid card' do
    fill_in_invalid_user_info
    fill_in_invalid_card
    click_button "Submit Payment"
    sleep 2
    expect(page).to have_content("Your card number is invalid.")
  end

  scenario 'with invalid user info and declined card' do
    fill_in_invalid_user_info
    fill_in_declined_card
    click_button "Submit Payment"
    sleep 2
    expect(page).to have_content("Please fix user errors")
  end


  def fill_in_valid_user_info
    fill_in "Email", with: "test@gmail.com"
    fill_in "Password", with: "password"
    fill_in "Full Name", with: "John Doe"
  end

  def fill_in_invalid_user_info
    fill_in "Email", with: "test@gmail.com"
    fill_in "Full Name", with: "John Doe"
  end  

  def fill_in_valid_card
    within_frame(find('iframe')) do 
      sleep 2 
      fill_in name: 'cardnumber', with: "4242424242424242"
      fill_in name: 'exp-date', with: '11/20'
      fill_in name: 'cvc', with: '123'
      fill_in name: 'postal', with: '90210'
    end
  end

  def fill_in_invalid_card
    within_frame(find('iframe')) do
      sleep 2  
      fill_in name: 'cardnumber', with: "4242424200000002"
      fill_in name: 'exp-date', with: '11/20'
      fill_in name: 'cvc', with: '123'
      fill_in name: 'postal', with: '90210'
    end
  end

    def fill_in_declined_card
    within_frame(find('iframe')) do
      sleep 2  
      fill_in name: 'cardnumber', with: "4000000000000002"
      fill_in name: 'exp-date', with: '11/20'
      fill_in name: 'cvc', with: '123'
      fill_in name: 'postal', with: '90210'
    end
  end


end