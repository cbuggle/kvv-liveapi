require 'test_helper'
require 'vcr'
require 'json'

describe KVV::Liveapi, :vcr do
  extend Minitest::Spec::DSL

  subject { KVV::Liveapi }

  describe "departures for stop by id" do

    let(:stop_id){'de:8212:401'}
    let(:unconnected_stop_id){'de:8212:25'}

    it "returns expected timetable" do
      subject.departures_bystop( stop_id ).must_equal expected_timetable("kvv_departures_by_stop_id")
    end

    it "rescues empty stop id" do
      subject.departures_bystop( nil ).must_equal( {} )
    end

    it "rescues defective KVV response on unconnected stop" do
      # There are stops which are not connected to the kvv's tracking system.
      # When requesting departures for such an unconnected stop, live.kvv.de does respond with 'HTTP Status 400 Bad Request', which is innapropriate as the request is actually properly formed and the requested stop_id is perfectly valid and existant.
      # We have no way to determine whether a given stop_id is connected or not before requesting its timetable and look for this crappy response (which we then want to rescue). Will report this to kvv. cbuggle, 15.1.2018
      subject.departures_bystop( unconnected_stop_id ).must_equal( {} )
    end
  end

  describe "departures for stop by name" do

    let(:stop_name){'Kar'}

    it "returns expected timetable" do
      subject.departures_bystop_name( stop_name ).must_equal expected_timetable( "kvv_departures_by_stop_name")
    end

    it "rescues empty stop name" do
      subject.departures_bystop_name( '' ).must_equal( {} )
    end

    it "rescues nil stop name" do
      subject.departures_bystop_name( nil ).must_equal( {} )
    end

    it "rescues trailing whitespaces" do
      subject.departures_bystop_name( "Gotte " ).must_equal expected_timetable("kvv_departures_by_gottesauer_platz")
    end

    it "allows spaces" do
      subject.departures_bystop_name( "Durlach Friedhof" ).must_equal expected_timetable("kvv_departures_by_durlach_friedhof")
    end
  end

  describe "departures for route" do
    let(:route){ "3" }
    let(:stop_id){'de:8212:60'} # Karlsruhe Europaplatz, served by route 3
    let(:unserved_stop_id){'de:8212:401'} # Karlsruhe Kar-Wilhelm-Platz, not served by route 3
    let(:unconnected_stop_id){'de:8212:25'}

    it "returns expected timetable" do
      subject.departures_by_route(route: route, stop_id: stop_id).must_equal expected_timetable( "kvv_departures_by_route")
    end

    it "rejects empty route" do
      subject.departures_by_route(route: nil, stop_id: stop_id).must_equal( {} )
    end

    it "rescues empty stop" do
      subject.departures_by_route(route: route, stop_id: nil).must_equal( {} )
    end

    it "rescues unserved stop name" do
      subject.departures_by_route(route: route, stop_id: unserved_stop_id).must_equal expected_timetable("kvv_departures_for_unserved_stop_by_route")
    end

    it "rescues unconnected stop name" do
      subject.departures_by_route(route: route, stop_id: unconnected_stop_id).must_equal( {} )
    end

  end

end
