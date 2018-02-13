require 'test_helper'
require 'vcr'
require 'json'


describe KVV::Liveapi, :vcr do
  extend Minitest::Spec::DSL

  subject { KVV::Liveapi }

  let(:expected_stops){ JSON.parse expectation_file( expected_stops_filename ) }

  describe "stops by name" do
    let(:stop_name_input){ "Kar" }
    let(:expected_stops_filename){ 'kvv_stops_by_name' }

    it "returns expected stops" do
      subject.stops_by_name( stop_name_input ).must_equal expected_stops
    end

    it "single character returns no stops" do
      # KVV requires at least two letters; we catch it on our side to prevent a useless request. cbuggle, 29.1.2017
      subject.stops_by_name( 'K' ).must_equal []
    end

    it "empty returns no stops" do
      subject.stops_by_name( '' ).must_equal []
    end

    it "nil returns no stops" do
      subject.stops_by_name( nil ).must_equal []
    end
  end

  describe "stops_by_latlon" do
    let(:lat_lon){ {lat: 49.02140112, lon: 8.41370115} }
    let(:expected_stops_filename) { "kvv_stops_by_latlon" }

    it "returns expected stops" do
      subject.stops_by_latlon( lat_lon ).must_equal( expected_stops )
    end

    it "rejects lat: nil" do
      subject.stops_by_latlon( lat_lon.merge(lat: nil) ).must_equal []
    end

    it "rejects lon: nil" do
      subject.stops_by_latlon( lat_lon.merge(lon: nil) ).must_equal []
    end
  end

end
