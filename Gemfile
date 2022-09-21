source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
# положить apt файл на heroku
ruby '3.0.2'

gem 'rails', '~> 7.0.3', '>= 7.0.3.1'

gem 'devise'
gem 'devise-i18n'
gem 'rails-i18n', '~> 7.0', '>= 7.0.5'

gem 'aws-sdk-s3', require: false
gem "image_processing", ">= 1.2"

gem 'sprockets-rails'

gem 'cssbundling-rails'
gem 'jsbundling-rails'

gem 'mailjet'
gem 'dotenv-rails', groups: [:development, :test]

gem 'mini_magick'

gem 'puma', '~> 5.0'

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'bootsnap', require: false

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'sqlite3', '~> 1.4'
end

group :development do
  gem 'web-console'
end

group :production do
  gem 'pg'
end
