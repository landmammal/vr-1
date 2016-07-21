require 'rails_helper'

  feature 'Lesson', type: :feature do
    context 'instructor' do

      let!(:instructor) { FactoryGirl.create(:user, :as_instructor) }
      let!(:course) { FactoryGirl.create :course, instructor: instructor }
      let!(:topic) { FactoryGirl.create :topic, instructor: instructor }
      let!(:lesson) { FactoryGirl.create :lesson, instructor: instructor }

      it 'can create a lesson' do
        visit new_user_session_path
        fill_in 'Email', with: instructor.email
        fill_in 'Password', with: instructor.password
        click_on 'LOG IN'
        click_on course.title
        click_on topic.title
        click_on 'Create Lesson'
        fill_in 'title', with: Faker::Lorem.word
        fill_in 'description', with: Faker::Lorem.paragraph
        fill_in 'tags', with: 'hello,my,name'
        click_on 'Create Lesson'
        expect(page).to have_content 'Lesson was successfully created.'
      end

      it 'can view a lesson he create it' do
        visit new_user_session_path
        fill_in 'Email', with: instructor.email
        fill_in 'Password', with: instructor.password
        click_on 'LOG IN'
        click_on course.title
        click_on topic.title
        expect(page).to have_content(:lesson)
      end

      it 'can edit a lesson' do
        fill_in 'Email', with: instructor.email
        fill_in 'Password', with: instructor.password
        click_on 'LOG IN'
        click_on course.title
        click_on topic.title
        click_on(:lesson)
        click_on 'Edit lesson'
        fill_in 'title', with: Faker::Lorem.word
        fill_in 'description', with: Faker::Lorem.paragraph 
        click_on 'Update Lesson'
        expect(page).to have_content 'Lesson was successfully updated.'
      end

      it 'can destroy a lessson he crreate it' do
        fill_in 'Email', with: instructor.email
        fill_in 'Password', with: instructor.password
        click_on 'LOG IN'
        click_on course.title
        click_on topic.title
        click_on(:lesson)
        click_on 'X'
        expect(page).to have_content 'Lesson was successfully destroyed.'
      end
    end
  end
