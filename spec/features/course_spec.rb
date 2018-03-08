require 'rails_helper'

  feature 'Course', type: :feature do
    context 'Instructor', js: true do

      let!(:instructor) { FactoryBot.create(:user, :as_instructor) }
      let!(:course) { FactoryBot.create :course, instructor: instructor }

      it "creates a course" do
        visit new_user_session_path
        fill_in 'Email', with: instructor.email
        fill_in 'Password', with: instructor.password
        click_on 'LOG IN'

        click_on 'Create New Course'
        fill_in 'Title', with: Faker::Space.planet
        fill_in 'Description', with: Faker::Lorem.paragraph
        fill_in 'tags (comma separated)', with: 'hello,tags,king'
        click_on 'Create Course'
        expect(page).to have_content 'Course was successfully created.'
      end

      it "sees a course he created" do
        visit new_user_session_path
        fill_in 'Email', with: instructor.email
        fill_in 'Password', with: instructor.password
        click_on 'LOG IN'
        expect(page).to have_content(:course)
      end

      it "Edits course" do
        visit new_user_session_path
        fill_in 'Email', with: instructor.email
        fill_in 'Password', with: instructor.password
        click_on 'LOG IN'
        click_on(:course)
        click_on 'Edit Course'
        fill_in 'Title', with: Faker::Space.planet
        fill_in 'Description', with: Faker::Space.agency
        click_on 'Update Course'
        expect(page).to have_content 'Course was successfully updated.'
      end

      it "deletes a course" do
        visit new_user_session_path
        fill_in 'Email', with: instructor.email
        fill_in 'Password', with: instructor.password
        click_on 'LOG IN'
        within '.home_card_delete' do
          accept_alert do
            click_on 'X'
          end
        end
        expect(page).to have_content 'Course was successfully destroyed.'
      end
    end
  end
