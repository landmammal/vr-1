require 'rails_helper'

RSpec.describe "progresses/show", type: :view do
  before(:each) do
    @progress = assign(:progress, Progress.create!(
      :lesson => nil,
      :user => nil,
      :explanation => nil,
      :prompt => nil,
      :model => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
