require 'rails_helper'

RSpec.describe Practice, type: :model do
  context "new practice" do
    let! (:user) {FactoryGirl.create(:user)}
    let! (:practice) {FactoryGirl.create(:practice, user: user)}
      it 'should be assigned user' do
        expect(user).to eq(practice.user)
      end
  end
end
