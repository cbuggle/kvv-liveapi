ENV["RAILS_ENV"] = "test"
require 'support/simplecov'

require "kvv/liveapi"

require "minitest/autorun"

require 'support/vcr'
require 'support/minitest_helpers'
require "minitest/pride"

require "minitest/reporters"
Minitest::Reporters.use!
