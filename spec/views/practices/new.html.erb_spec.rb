# require 'rails_helper'
#
# RSpec.describe "practices/new", type: :view do
#   before(:each) do
#     assign(:practice, Practice.new(
#       :token => "MyString",
#       :video_token => "MyString",
#       :completed => false,
#       :user => nil
#     ))
#   end
#
#   it "renders new practice form" do
#     render
#
#     assert_select "form[action=?][method=?]", practices_path, "post" do
#
#       assert_select "input#practice_token[name=?]", "practice[token]"
#
#       assert_select "input#practice_video_token[name=?]", "practice[video_token]"
#
#       assert_select "input#practice_completed[name=?]", "practice[completed]"
#
#       assert_select "input#practice_user_id[name=?]", "practice[user_id]"
#     end
#   end
# end
