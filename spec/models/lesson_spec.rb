require 'rails_helper'

RSpec.describe Lesson, type: :model do
  context "new lesson" do
    let! (:user) {FactoryGirl.create(:user)}
    let! (:course) {FactoryGirl.create(:course, user: user)}
    let! (:chapter) {FactoryGirl.create(:chapter, course: course)}
    let! (:lesson) {FactoryGirl.create_list(:lesson, 3, chapter: chapter)}


      it 'should have all the parents info' do

        expect(lesson.last.chapter.course.user).to eq user

      end
  end
end
