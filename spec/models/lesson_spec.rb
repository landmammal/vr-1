# require 'rails_helper'
#
# RSpec.describe Lesson, type: :model do
#   context "new lesson" do
#     let! (:user) {FactoryBot.create(:user)}
#     let! (:course) {FactoryBot.create(:course, user: user)}
#     let! (:topic) {FactoryBot.create(:topic, course: course)}
#     let! (:lesson) {FactoryBot.create_list(:lesson, 3, topic: topic)}
#       it 'should have all the parents info' do
#         expect(lesson.first.topic.course.user).to eq user
#       end
#   end
#
# end
