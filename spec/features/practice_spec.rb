require "rails_helper"

  feature 'making practice video', type: :feature do
    context 'Trainee submits a video' do
      let! (:user) {FactoryGirl.create(:user)}
      let! (:course) {FactoryGirl.create(:course, user: user)}
      let! (:chapter) {FactoryGirl.create(:chapter, course: course)}
      let! (:lesson) {FactoryGirl.create(:lesson, chapter: chapter)}
      let! (:trainee) {FactoryGirl.create(:user)}


      it 'with valid credentials', js: true do
        visit new_user_session_path
        fill_in 'Email', with: trainee.email
        fill_in 'Password', with: trainee.password
        click_on 'Log in'
        expect(page).to have_content 'Signed in successfully'
        visit lessons_path
        binding.pry



      end
      #
      # it 'user cannot sign in with invalid email' do
      #   signin('invalid@email.com', user.password)
      #   expect(page).to have_content 'Invalid Email or password'
      # end
      #
      # it 'user cannot sign in with invalid password' do
      #   signin(user.email, 'invalidpass')
      #   expect(page).to have_content 'Invalid Email or password'
      # end
    end
  end
