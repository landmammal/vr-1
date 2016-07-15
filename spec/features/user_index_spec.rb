# require 'rails_helper'
#
# feature 'making a course', type: :feature do
#   scenario 'user can create a course' do
#     user = FactoryGirl.create(:user, :instructor)
#     login_as(user, scope: :user)
#     visit users_path
#     expect(page).to have_content user.email
#   end
# end
#
# feature 'User index page', type: :feature do
#   scenario 'user sees own email address' do
#     user = FactoryGirl.create(:user, :admin)
#     login_as(user, scope: :user)
#     visit users_path
#     expect(page).to have_content user.email
#   end
# end
