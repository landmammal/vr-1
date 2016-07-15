require 'rails_helper'

  feature 'Course', type: :feature do
    context 'Instructor' do

      let! (:instructor) {FactoryGirl.create(:user, :as_instructor)}
      # let! (:course) {FactoryGirl.create(: )}
      # let! (:topic) {FactoryGirl.create(: )}
      # let! (:lesson) {FactoryGirl.create(: )}
      # let! (:explanation) {FactoryGirl.create(: )}
      # let! (:prompt) {FactoryGirl.create(: )}
      # let! (:model) {FactoryGirl.create(: )}


      it "creates a course", focus: true, js: true do
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

      it "creates a topic" do

      end

      it "creates a lesson" do

      end

      it "creates a explanation" do

      end

      it "creates a prompt" do

      end

      it "creates a model" do

      end
    end
  end
