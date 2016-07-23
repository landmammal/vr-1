require 'rails_helper'

RSpec.describe "rehearsals/show", type: :view do
  before(:each) do
    @rehearsal = assign(:rehearsal, Rehearsal.create!(
      :course => nil,
      :progress => nil,
      :group => nil,
      :course_number => 2,
      :token => "Token",
      :video_token => "Video Token"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Token/)
    expect(rendered).to match(/Video Token/)
  end
end
