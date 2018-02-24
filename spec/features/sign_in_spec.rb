require "rails_helper"

  feature 'Sign in', type: :feature do
    context 'A user signs in' do

      let!(:user) { FactoryBot.create(:user) }

      it 'fails if not registered' do
         signin('person@example.com', 'password')
         expect(page).to have_content 'Invalid Email or password'
      end

      it 'passes with valid credentials' do
        visit new_user_session_path
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_on 'LOG IN'
        expect(page).to have_content 'Signed in successfully'
      end

      it 'fails with invalid email' do
        signin('invalid@email.com', user.password)
        expect(page).to have_content 'Invalid Email or password'
      end

      it 'fails with invalid password' do
        signin(user.email, 'invalidpass')
        expect(page).to have_content 'Invalid Email or password'
      end
    end
  end
