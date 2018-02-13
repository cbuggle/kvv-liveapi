ENV["RAILS_ENV"] = "test"
require 'support/simplecov'

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require "kvv/liveapi"

require "minitest/autorun"

require 'support/vcr'

# To add Capybara feature tests add `gem "minitest-rails-capybara"`
# to the test group in the Gemfile and uncomment the following:
# require "minitest/rails/capybara"

require 'support/minitest_helpers'
require "minitest/pride"

require "minitest/reporters"
Minitest::Reporters.use!
