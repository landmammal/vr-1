require "rails_helper"
RSpec.describe 'User signin', type: :feature do
  # feature 'Sign in', :devise do
    context 'A user signs in' do
      # it 'user cannot sign in if not registered' do
      #    signin('person@example.com', 'password')
      #    expect(page).to have_content 'Invalid Email or password'
      # end

      it 'user can sign in with valid credentials' do
        user = FactoryGirl.create(:user)
        visit new_user_session_path
        fill_in 'Email', with: user.email

        fill_in 'Password', with: user.password

        click_on 'Log in'
        # signin(user.email, user.password)
        expect(page).to have_content 'Signed in successfully'
      end
      #
      # it 'user cannot sign in with invalid email' do
      #   user = FactoryGirl.create(:user)
      #   signin('invalid@email.com', user.password)
      #   expect(page).to have_content 'Invalid Email or password'
      # end
      #
      # it 'user cannot sign in with invalid password' do
      #   user = FactoryGirl.create(:user)
      #   signin(user.email, 'invalidpass')
      #   expect(page).to have_content 'Invalid Email or password'
      # end
    end
  # end
end
