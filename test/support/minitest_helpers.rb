class Minitest::Test
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #  fixtures :all

  # Add more helper methods to be used by all tests here...
  def expectation_file name
    File.read( File.join( File.dirname(__dir__), "expectations", "#{name}.json" ))
  end

  def expected_timetable filename
    JSON.parse expectation_file( filename )
  end

  # Runs tests in parallel (multithreaded).
  parallelize_me!

  # Generates nicer diffs for complicated, nested values.
  make_my_diffs_pretty!
end
