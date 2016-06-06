require 'rails_helper'

RSpec.describe Practice, type: :model do
  context "new practice" do
    let! (:user) {FactoryGirl.create(:user)}
    let! (:practice) {FactoryGirl.create(:practice, user: user)}
      it 'should be assigned user' do
        expect(user).to eq(practice.user)
      end
  end

  context "new practice" do
    let! (:user) {FactoryGirl.create(:user)}
    let! (:course) {FactoryGirl.create(:course, user: user)}
    let! (:chapter) {FactoryGirl.create(:chapter, course: course)}
    let! (:lesson) {FactoryGirl.create(:lesson, chapter: chapter)}
    let! (:practice) {FactoryGirl.create(:practice, lesson: lesson, user: user)}

      it 'should lesson id when created under lesson' do
        expect(practice.lesson).to eq lesson
      end
  end
end
