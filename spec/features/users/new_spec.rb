require 'rails_helper'

RSpec.describe 'the new user view' do
  it 'has a form to register a new user' do
    visit register_path

    fill_in 'Email', with: 'NewUserOne@gmail.com'
    fill_in 'Name', with: 'Terry Crews'
    fill_in 'Password', with: 'Test'
    fill_in 'Password confirmation', with: 'Test'

    click_on 'Register'

    expect(current_path).to eq("/users/#{User.first.id}/dashboard")
    expect(User.first.name).to eq('Terry Crews')
  end

  it 'will not register an invalid user' do
    visit register_path

    fill_in 'Email', with: ''
    fill_in 'Name', with: ''

    click_on 'Register'

    within '.flash' do
      expect(page).to have_content('Invalid Entry')
    end

    within '.error-messages' do
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Email can't be blank")
    end
  end

  it 'shows error message when wrong info is entered' do
    User.create!(name: 'drew', email: 'drewmail@woo.com', password: 'aaaaa', password_confirmation: 'aaaaa')

    visit register_path
    fill_in 'Name', with: 'drewb'
    fill_in 'Email', with: 'drewmail@woo.com'
    fill_in 'Password', with: 'aaaaa'
    fill_in 'Password confirmation', with: 'aaaaa'
    click_button('Register')

    expect(current_path).to eq('/users')
    expect(page).to have_content('Email has already been taken')
  end

  it 'shows error message when password and password_confirmation do not match' do
    visit register_path
    fill_in 'Name', with: 'drewb'
    fill_in 'Email', with: 'drewmail@woo.com'
    fill_in 'Password', with: 'bbbbb'
    fill_in 'Password confirmation', with: 'aaaaa'
    click_button('Register')

    expect(current_path).to eq('/users')
    expect(page).to have_content("Password confirmation doesn't match Password")
  end
end
