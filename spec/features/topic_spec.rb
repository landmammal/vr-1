require rails_helper

  feature 'topic', type: :feature do
    context 'instructor' do

      let! (:instructor) { FactoryGirl.create :instructor, :as_instructor }
      let! (:course) { FactoryGirl.create :course, instructor: instructor }

      it 'can create a topic' focus: true, js: true do
        visit new_user_session_path
        fill_in 'Email', with: instructor.email
        fill_in 'Password', with: instructor.password
        click_on 'LOG IN'
        click_on course.title

        click_on 'Create New Topic'
        fill_in 'title', with: 'test topic title'
        fill_in 'description', with: 'this is a topic description'
        fill_in 'tags', with: 'test,this,tags'
        click_on 'Create Topic'
        expect(page).to have_content 'Topic was successfully updated.'
      end
    end
  end
