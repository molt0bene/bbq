source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

gem 'rails', '~> 7.0.3', '>= 7.0.3.1'

gem 'font-awesome-rails', '~> 4.7', '>= 4.7.0.8'

gem 'devise'
gem 'devise-i18n'
gem 'rails-i18n', '~> 7.0', '>= 7.0.5'

gem 'carrierwave'
gem 'rmagick'

gem 'sprockets-rails'

gem 'cssbundling-rails'
gem 'jsbundling-rails'

gem 'puma', '~> 5.0'
gem 'importmap-rails'
gem 'turbo-rails'
gem 'stimulus-rails'
gem 'jbuilder'

gem 'tzinfo-data', platforms: %i[ mingw mswin x64_mingw jruby ]
gem 'bootsnap', require: false

group :development, :test do
  gem 'debug', platforms: %i[ mri mingw x64_mingw ]
  gem 'sqlite3', '~> 1.4'
end

group :development do
  gem 'web-console'
end

group :production do
  gem 'pg'
end
