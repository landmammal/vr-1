require "rails_helper"
# line below is not need it anymore
  feature 'Sign in', type: :feature do
    context 'A user signs in' do

      let!(:user){ FactoryGirl.create(:user) }

      it 'fails if not registered' do
         signin('person@example.com', 'password')
         expect(page).to have_content 'Invalid Email or password'
      end

      it 'with valid credentials', js: true do
        visit new_user_session_path
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_on 'Log in'
        expect(page).to have_content 'Signed in successfully'
      end

      it 'user cannot sign in with invalid email' do
        signin('invalid@email.com', user.password)
        expect(page).to have_content 'Invalid Email or password'
      end

      it 'user cannot sign in with invalid password' do
        signin(user.email, 'invalidpass')
        expect(page).to have_content 'Invalid Email or password'
      end
    end
  end
