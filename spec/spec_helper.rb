ENV['SINATRA_ENV'] = 'test'

require './config/environment'

require 'simplecov'
SimpleCov.start

Dir['./app/*/*.rb'].each { |file| require file }

require 'figaro/sinatra'
require 'webmock/rspec'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.include Rack::Test::Methods
end

def app
  Rack::Builder.parse_file('config.ru').first
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
  config.filter_sensitive_data('<MAP_API_KEY>') { ENV['MAP_API_KEY'] }
  config.default_cassette_options = { re_record_interval: 7.days }
  config.configure_rspec_metadata!
end

def check_hash_structure(object, key, data_type)
  expect(object).to have_key(key)
  expect(object[key]).to be_a(data_type)
end
