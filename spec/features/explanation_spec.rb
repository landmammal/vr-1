require 'rails_helper'

feature 'Explanation', type: :feature do
  context 'instructor' do

    let!(:instructor) { FactoryGirl.create(:user, :as_instructor) }
    let!(:course) { FactoryGirl.create :course, instructor: instructor }
    let!(:topic) { FactoryGirl.create :topic, instructor: instructor }
    let!(:lesson) { FactoryGirl.create :lesson, instructor: instructor }
    let!(:explanation) { FactoryGirl.create :explanation, instructor: instructor }

    it 'can create and Explanation' do
      visit new_user_session_path
      fill_in 'Email', with: instructor.email
      fill_in 'Password', with: instructor.password
      click_on 'LOG IN'
      click_on course.title
      click_on topic.title
      click_on lesson.title
      click_on 'Create Explanation'
      fill_in token, with: Faker::Space.agency
      fill_in video_token, with: Faker::Space.agency 
      click_on 'Save Explanation'
      expect(page).to have_content 'Explanation has been saved'
    end

    it 'can edit Explanation' do

    end

    it 'can '
  end
end
