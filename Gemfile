source 'https://rubygems.org'

gem 'rails', '3.2.8'
gem 'bootstrap-sass', '2.0.4'
gem 'devise'
gem 'cancan'
gem 'tlsmail'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :development do
	gem 'sqlite3'
	gem 'guard-rspec', '0.5.5'
	gem 'rspec-rails', '2.11.0'
end

group :production do
  gem 'pg', '0.14.0'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'



group :test do
	gem 'cucumber-rails', '1.2.1', :require => false
	gem 'rspec-rails', '2.11.0'
	gem 'database_cleaner', '0.8.0'
	gem 'factory_girl_rails', '4.0.0'
	gem 'capybara-screenshot'
	gem 'launchy'
  gem 'capybara'
	gem 'capybara-webkit'
	gem 'rb-fsevent', :require => false
	gem 'growl'
	gem 'guard-spork'
	gem 'spork'
	gem 'guard-cucumber'
end