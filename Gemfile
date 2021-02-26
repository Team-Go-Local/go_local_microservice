source "https://rubygems.org"

git_source(:github) do |repo|
  "https://github.com/#{repo}.git"
end

gem 'faraday'
gem 'fast_jsonapi'
gem 'figaro', git: 'https://github.com/bpaquet/figaro.git', branch: 'sinatra'
gem 'sinatra', require: 'sinatra/base'
gem 'shotgun'
gem 'require_all'

group :development, :test do
  gem 'factory_bot'
  gem 'faker'
  gem 'pry'
  gem 'rspec'
  gem 'simplecov'
end

group :test do
  gem 'vcr'
  gem 'webmock'
end
