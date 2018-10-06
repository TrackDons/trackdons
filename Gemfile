source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Core
gem 'rails', '5.1.6'
gem "pg", "~> 0.18" 
gem 'bcrypt'

# Frontend
gem "bourbon", "~> 4.3.4"
gem 'sass-rails', '~> 5.0.0'
gem 'uglifier', '>= 1.3.0'
gem "jquery-rails"
gem 'ejs'
# gem "jquery-ui-rails"
gem 'jquery-turbolinks'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
gem "i18n-js", ">= 3.0.0.rc8" 


# Utilities
gem 'friendly_id', '~> 5.2', '>= 5.2.4'
gem 'i18n_country_select'
gem 'i18n-country-translations'
gem 'redcarpet'
gem 'money-rails'
gem 'rollbar'
gem 'meta-tags'
gem 'rails-i18n'
gem 'dynamic_form'
gem 'globalize', '~> 5.1'
gem 'acts_as_follower', github: 'tcocca/acts_as_follower', branch: 'master'
gem 'acts-as-taggable-on', '~> 6.0'
gem 'hstore_accessor'

# Social networks
gem 'omniauth-twitter'
gem 'twitter'
gem 'omniauth-facebook'
gem 'koala'

group :development, :test do
  gem 'spring'
  gem "byebug", platform: :mri
  gem 'jasmine'
  gem "puma"
end

group :test do
  gem 'database_cleaner'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'launchy'
  gem 'email_spec'
  gem 'timecop'
end

group :development do
  gem 'mina'
  gem "listen"
  gem "spring-watcher-listen", "~> 2.0.0"
end
