require 'rails_helper'

feature 'Explanation', type: :feature do
  context 'instructor' do

    let!(:instructor) { FactoryBot.create(:user, :as_instructor) }
    let!(:course) { FactoryBot.create :course, instructor: instructor }
    let!(:topic) { FactoryBot.create :topic, instructor: instructor, courses: [course] }
    let!(:lesson) { FactoryBot.create :lesson, instructor: instructor, topics: [topic] }
    let!(:explanation) { FactoryBot.create :explanation, instructor: instructor, lessons: [lesson] }
    # 
    # it 'can create and Explanation', focus: true, js: true do
    #   visit new_user_session_path
    #   fill_in 'Email', with: instructor.email
    #   fill_in 'Password', with: instructor.password
    #   click_on 'LOG IN'
    #   click_on course.title
    #   click_on topic.title
    #   click_on lesson.title
    #   click_on 'Add Explanation'
    #   fill_in token, with: Faker::Space.agency
    #   fill_in video_token, with: Faker::Space.agency
    #   click_on 'Save Explanation'
    #   expect(page).to have_content 'Explanation has been saved'
    # end

    it 'can edit Explanation' do

    end

    it 'can '
  end
end
