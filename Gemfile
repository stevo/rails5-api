source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'flex'
gem 'flex-rails'
gem 'jsonapi-resources'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.4'
gem 'rest-client'

group :development, :test do
  gem 'pry-rails'
end

group :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'simplecov', require: false
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
