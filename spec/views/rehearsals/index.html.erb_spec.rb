require 'rails_helper'

RSpec.describe "rehearsals/index", type: :view do
  before(:each) do
    assign(:rehearsals, [
      Rehearsal.create!(
        :course => nil,
        :progress => nil,
        :group => nil,
        :course_number => 2,
        :token => "Token",
        :video_token => "Video Token"
      ),
      Rehearsal.create!(
        :course => nil,
        :progress => nil,
        :group => nil,
        :course_number => 2,
        :token => "Token",
        :video_token => "Video Token"
      )
    ])
  end

  it "renders a list of rehearsals" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Token".to_s, :count => 2
    assert_select "tr>td", :text => "Video Token".to_s, :count => 2
  end
end
