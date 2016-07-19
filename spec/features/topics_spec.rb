require 'rails_helper'

feature "Topic" do
  context 'Instructor' do

    let! (:instructor) { FactoryGirl.create(:user, :as_instructor) }
    let! (:course) { create :course, instructor: instructor }
    let! (:topic) { create :topic, instructor: instructor }


    # it "can see hes topics", focus: true, js: true do
    #   visit new_user_session_path
    #   fill_in 'Email', with: instructor.email
    #   fill_in 'Password', with: instructor.password
    #   click_on 'LOG IN'
    #   click_on course.title
    #   expect(page).to have_content topic.title
    #
    # end

    # it "creates a topic", focus: true, js: true do
    #   visit new_user_session_path
    #   fill_in 'Email', with: instructor.email
    #   fill_in 'Password', with: instructor.password
    #   click_on 'LOG IN'
    #
    #   click_on course.title

  end
end
