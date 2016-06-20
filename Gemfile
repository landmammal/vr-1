source 'https://rubygems.org'

# user authentication and authorization by role
gem 'devise'
gem 'pundit'

# Al Delcy GEMS
gem 'font-awesome-sass'
gem 'sprockets', '>= 3.0.0'
gem 'sprockets-es6'
gem 'carrierwave'
#=====================================

# pre install ready gems
gem 'rails', '4.2.6'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'hirb'
gem 'rake', '~> 11.1.2'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
group :production do
  gem 'pg'
  gem 'rails_12factor'
end
group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails' # Test Helper
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'pry-byebug' # Break in console
  gem 'pry-rails'
  gem 'awesome_print'
  gem 'faker'
  gem 'database_cleaner'
  gem 'shoulda-matchers' # Model Testing Help for Rspec

end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'better_errors' # Better Errors
end
