source 'https://rubygems.org'


ruby '2.3.1'
gem 'rails', '5.0.0.1'
gem 'rb-readline'

# user authentication and authorization by role
gem 'devise'
gem 'pundit'
gem 'unirest'
gem 'http-cookie', '~> 1.0', '>= 1.0.3'
gem 'netrc', '~> 0.11.0'
gem 'mime-types', '~> 3.1'
gem 'rest-client'

# user payment information
gem 'stripe', :git => 'https://github.com/stripe/stripe-ruby'

# for user profile and banner
gem 'paperclip'
gem 'aws-sdk'
gem 'aws-sdk-s3'

gem 'font-awesome-sass'
gem 'sprockets-es6'
gem 'carrierwave'
gem 'fog-aws'

gem 'roadie'

# for my secrets
gem 'dotenv'

# pre install ready gems
gem 'sass-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'hirb'
gem 'rails_12factor'
gem 'kaminari' # Pagination
gem 'remotipart', '~> 1.2' # Ajax Image Uploading

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development


group :production do
  gem 'puma'
  gem 'pg', '0.20'
end

group :development, :test do
  gem 'dotenv-rails'
  gem 'sqlite3'
  gem 'rspec-rails' # Test Helper
  gem 'factory_bot'
  gem 'capybara'
  gem 'letter_opener', :git => 'https://github.com/ryanb/letter_opener' # preview email without actually sending it
  gem 'letter_opener_web', :git => 'https://github.com/fgrehm/letter_opener_web' # lets us preview the emails in our web browser
  gem 'selenium-webdriver'
  gem 'pry-byebug' # Break in console
  gem 'pry-rails'
  gem 'awesome_print'
  gem 'faker'
  gem 'database_cleaner'
  gem 'shoulda-matchers' # Model Testing Help for Rspec
  gem 'web-console', '~> 2.0' # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'spring'
  gem 'better_errors' # Better Errors
  gem 'listen', '~> 3.0'

  # LIVE RELOADING
  gem 'guard', '>= 2.2.2', require: false
  gem 'guard-livereload', '~> 2.5.2', require: false
  gem 'rack-livereload'
  gem 'rb-fsevent', require: false
end
