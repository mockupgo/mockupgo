source 'https://rubygems.org'

gem 'rails', '3.2.8'
# gem 'bootstrap-sass', '2.0.4'
gem 'bootstrap-sass', git: 'git://github.com/thomas-mcdonald/bootstrap-sass', branch: '2.1-wip'
gem 'devise'
gem 'cancan'
gem 'activeadmin'
gem 'meta_search', '>= 1.1.0.pre'
gem 'jquery-rails'
gem 'haml'
gem 'pjax_rails'

gem 'rmagick'
gem 'carrierwave'

group :development do
	gem 'sqlite3'
	gem 'guard-rspec', '0.5.5'
	gem 'rspec-rails', '2.11.0'
  gem 'tlsmail'
  gem 'annotate', ">=2.5.0"
end

group :production do
  gem 'pg', '0.14.0'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end


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