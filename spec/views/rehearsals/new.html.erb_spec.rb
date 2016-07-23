require 'rails_helper'

RSpec.describe "rehearsals/new", type: :view do
  before(:each) do
    assign(:rehearsal, Rehearsal.new(
      :course => nil,
      :progress => nil,
      :group => nil,
      :course_number => 1,
      :token => "MyString",
      :video_token => "MyString"
    ))
  end

  it "renders new rehearsal form" do
    render

    assert_select "form[action=?][method=?]", rehearsals_path, "post" do

      assert_select "input#rehearsal_course_id[name=?]", "rehearsal[course_id]"

      assert_select "input#rehearsal_progress_id[name=?]", "rehearsal[progress_id]"

      assert_select "input#rehearsal_group_id[name=?]", "rehearsal[group_id]"

      assert_select "input#rehearsal_course_number[name=?]", "rehearsal[course_number]"

      assert_select "input#rehearsal_token[name=?]", "rehearsal[token]"

      assert_select "input#rehearsal_video_token[name=?]", "rehearsal[video_token]"
    end
  end
end
