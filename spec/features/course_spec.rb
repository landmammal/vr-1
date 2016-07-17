require 'rails_helper'

  feature 'Course', type: :feature do
    context 'Instructor' do

      let!(:instructor) { FactoryGirl.create(:user, :as_instructor) }
      let!(:course) { FactoryGirl.create :course, instructor: instructor }
      # let!(:course) { FactoryGirl.create :course, instructor: instructor }
      # let! (:topic) {FactoryGirl.create(: )}
      # let! (:lesson) {FactoryGirl.create(: )}
      # let! (:explanation) {FactoryGirl.create(: )}
      # let! (:prompt) {FactoryGirl.create(: )}
      # let! (:model) {FactoryGirl.create(: )}


      it "creates a course", js: true do
        visit new_user_session_path
        fill_in 'Email', with: instructor.email
        fill_in 'Password', with: instructor.password
        click_on 'LOG IN'

        click_on 'Create New Course'
        fill_in 'Title', with: 'Course fuking title'
        fill_in 'Description', with: 'this is a test description'
        fill_in 'tags (comma separated)', with: 'hello,tags,king'
        click_on 'Create Course'
        expect(page).to have_content 'Course was successfully created.'
      end

      it "sees a course he created", js: true do
        visit new_user_session_path
        fill_in 'Email', with: instructor.email
        fill_in 'Password', with: instructor.password
        click_on 'LOG IN'
        expect(page).to have_content(:course)
      end

      it "Edits course" do
  

      end

      it "deletes course" do

      end

      it "buys another course" do

      end
    end
  end
