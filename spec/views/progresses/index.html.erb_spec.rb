require 'rails_helper'

RSpec.describe "progresses/index", type: :view do
  before(:each) do
    assign(:progresses, [
      Progress.create!(
        :lesson => nil,
        :user => nil,
        :explanation => nil,
        :prompt => nil,
        :model => nil
      ),
      Progress.create!(
        :lesson => nil,
        :user => nil,
        :explanation => nil,
        :prompt => nil,
        :model => nil
      )
    ])
  end

  it "renders a list of progresses" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
