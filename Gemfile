source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'rails', '~> 5.2.1'
gem 'mysql2', '>= 0.4.4', '< 0.6.0'
gem 'grape', '~> 1.1.0'
gem 'grape-entity', '~> 0.7.1'
gem 'grape_logging', '~> 1.8.0'
gem 'grape-swagger', '~> 0.30.1'
gem 'grape-swagger-entity', '~> 0.2.5'
gem 'peatio', git: 'https://git@github.com/ysv/peatio-core', branch: 'funds-keeper-api'
gem 'puma', '~> 3.12.0'
gem 'faraday', '~> 0.14.0'
gem 'memoist'
gem 'rack-cors', :require => 'rack/cors'

group :development, :test do
  gem 'pry-byebug'
  gem 'grape_on_rails_routes', '~> 0.3.2'
  gem 'rspec-rails', '~> 3.8'
  gem 'factory_bot_rails', '~> 4.8'
  gem 'faker'
  gem 'webmock'
  gem 'database_cleaner',    '~> 1.6'
end

group :development do
  gem 'annotate', '~> 2.7'
  gem 'listen', '>= 3.0.5', '< 3.2'
end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
