source 'https://rubygems.org'

gem 'rails', '3.2.9'

gem 'gravatar_image_tag','1.0.0.pre2'
gem 'bootstrap-sass','2.0.4.0'
gem 'bcrypt-ruby','3.0.1'
gem 'jquery-rails'
gem 'will_paginate', '3.0.3'
gem 'bootstrap-will_paginate', '0.0.6'
gem 'nested_form'

group :production do
  gem 'pg'
end

group :development, :test do
# gem 'sqlite3'
  gem 'mysql2'
  gem 'rspec-rails','2.8.1'
  gem 'faker', '1.0.1'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.2'
  gem 'uglifier', '>= 1.2.3'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

group :development do
  # To use debugger
  gem 'ruby-debug19', :require => 'ruby-debug'
  gem 'annotate', '2.5.0'
end

group :test do
  gem 'rspec', '2.8.0'
  gem 'factory_girl_rails','1.4.0'
  gem 'capybara', '1.1.2'
end


