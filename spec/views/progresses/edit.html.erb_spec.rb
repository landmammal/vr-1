require 'rails_helper'

RSpec.describe "progresses/edit", type: :view do
  before(:each) do
    @progress = assign(:progress, Progress.create!(
      :lesson => nil,
      :user => nil,
      :explanation => nil,
      :prompt => nil,
      :model => nil
    ))
  end

  it "renders the edit progress form" do
    render

    assert_select "form[action=?][method=?]", progress_path(@progress), "post" do

      assert_select "input#progress_lesson_id[name=?]", "progress[lesson_id]"

      assert_select "input#progress_user_id[name=?]", "progress[user_id]"

      assert_select "input#progress_explanation_id[name=?]", "progress[explanation_id]"

      assert_select "input#progress_prompt_id[name=?]", "progress[prompt_id]"

      assert_select "input#progress_model_id[name=?]", "progress[model_id]"
    end
  end
end
