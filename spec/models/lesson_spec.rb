# require 'rails_helper'
#
# RSpec.describe Lesson, type: :model do
#   context "new lesson" do
#     let! (:user) {FactoryGirl.create(:user)}
#     let! (:course) {FactoryGirl.create(:course, user: user)}
#     let! (:topic) {FactoryGirl.create(:topic, course: course)}
#     let! (:lesson) {FactoryGirl.create_list(:lesson, 3, topic: topic)}
#       it 'should have all the parents info' do
#         expect(lesson.first.topic.course.user).to eq user
#       end
#   end
#
# end
