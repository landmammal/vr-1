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
    let! (:trainee) {FactoryGirl.create(:user)}
    let! (:practice) {FactoryGirl.create(:practice, lesson: lesson, user: trainee)}

      it 'should lesson id when created under lesson' do
        expect(practice.lesson).to eq lesson
      end
      it 'should not have conflict in user id' do
        expect(practice.user).to eq trainee
      end
  end
end
