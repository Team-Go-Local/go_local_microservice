source 'https://rubygems.org'

git_source(:github) do |repo|
  "https://github.com/#{repo}.git"
end

gem 'faraday'
gem 'fast_jsonapi'
gem 'figaro', git: 'https://github.com/bpaquet/figaro.git', branch: 'sinatra'
gem 'require_all'
gem 'shotgun'
gem 'sinatra', require: 'sinatra/base'

group :development, :test do
  gem 'pry'
end

group :test do
  gem 'rspec'
  gem 'rack-test'
  gem 'simplecov'
  gem 'vcr'
  gem 'webmock'
end
