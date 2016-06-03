require 'rails_helper'

RSpec.describe "practices/index", type: :view do
  before(:each) do
    assign(:practices, [
      Practice.create!(
        :token => "Token",
        :video_token => "Video Token",
        :completed => false,
        :user => nil
      ),
      Practice.create!(
        :token => "Token",
        :video_token => "Video Token",
        :completed => false,
        :user => nil
      )
    ])
  end

  it "renders a list of practices" do
    render
    assert_select "tr>td", :text => "Token".to_s, :count => 2
    assert_select "tr>td", :text => "Video Token".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
