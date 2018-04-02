require 'webmock/minitest'
require "minitest-vcr"
require 'vcr'

MinitestVcr::Spec.configure!
WebMock.disable_net_connect!(allow_localhost: true)

VCR.configure do |config|
  config.cassette_library_dir = "test/vcr_cassettes"
  config.hook_into :webmock
  config.default_cassette_options = { allow_unused_http_interactions: false, :record => :none }
  config.allow_http_connections_when_no_cassette = false
end
