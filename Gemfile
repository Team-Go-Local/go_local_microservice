source 'https://rubygems.org'

git_source(:github) do |repo|
  "https://github.com/#{repo}.git"
end

gem 'faraday'
gem 'fast_jsonapi'
gem 'figaro', git: 'https://github.com/bpaquet/figaro.git', branch: 'sinatra'
gem 'rack'
gem 'require_all'
gem 'shotgun'
gem 'sinatra', require: 'sinatra/base'

group :development, :test do
  gem 'capybara'
  gem 'factory_bot'
  gem 'faker'
  gem 'pry'
  gem 'rspec'
  gem 'simplecov'
end

group :test do
  gem 'rack-test'
  gem 'vcr'
  gem 'webmock'
end
