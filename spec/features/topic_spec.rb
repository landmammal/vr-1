require 'rails_helper'

  feature 'topic', type: :feature do
    context 'instructor', js: true do

      let! (:instructor) { FactoryBot.create(:user, :as_instructor) }
      let! (:course) { FactoryBot.create :course, instructor: instructor }
      let! (:topic) { FactoryBot.create :topic, instructor: instructor }

      it 'can create a topic' do
        visit new_user_session_path
        fill_in 'Email', with: instructor.email
        fill_in 'Password', with: instructor.password
        click_on 'LOG IN'
        page.find("#course_title").click
        click_on 'Create New Topic'
        fill_in 'Title', with: Faker::Space.planet
        fill_in 'Description', with: Faker::Lorem.paragraph
        fill_in 'tags (comma separated)', with: 'test,this,tags'
        click_on 'Create Topic'
        expect(page).to have_content 'Topic was successfully created.'
      end

      it 'can view a topic he create it' do
        visit new_user_session_path
        fill_in 'Email', with: instructor.email
        fill_in 'Password', with: instructor.password
        click_on 'LOG IN'
        click_on course.title
        expect(page).to have_content(:topic)
      end

      it 'can edit hes topic' do
        visit new_user_session_path
        fill_in 'Email', with: instructor.email
        fill_in 'Password', with: instructor.password
        click_on 'LOG IN'
        click_on course.title
        click_on(:topic)
        click_on 'Edit Topic'
        fill_in 'title', with: Faker::Space.planet
        click_on 'Save Topic'
        expect(page).to have_content 'Topic was successfully updated.'
      end

      it 'can delete hes topic' do
        visit new_user_session_path
        fill_in 'Email', with: instructor.email
        fill_in 'Password', with: instructor.password
        click_on 'LOG IN'
        click_on course.title
        click_on(:topic)
        click_on 'X'
        expect(page).to have_content 'Topic was successfully destroyed.'
      end
    end
  end
