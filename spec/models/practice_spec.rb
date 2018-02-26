# require 'rails_helper'
#
# RSpec.describe Practice, type: :model do
#   context "new practice" do
#     let! (:user) {FactoryBot.create(:user)}
#     let! (:practice) {FactoryBot.create(:practice, user: user)}
#       it 'should be assigned user' do
#         expect(user).to eq(practice.user)
#       end
#   end
#
#   context "new practice" do
#     let! (:user) {FactoryBot.create(:user)}
#     let! (:course) {FactoryBot.create(:course, user: user)}
#     let! (:topic) {FactoryBot.create(:topic, course: course)}
#     let! (:lesson) {FactoryBot.create(:lesson, topic: topic)}
#     let! (:trainee) {FactoryBot.create(:user)}
#     let! (:practice) {FactoryBot.create(:practice, lesson: lesson, user: trainee)}
#
#       it 'should lesson id when created under lesson' do
#         expect(practice.lesson).to eq lesson
#       end
#       it 'should not have conflict in user id' do
#         expect(practice.user).to eq trainee
#       end
#   end
# end
