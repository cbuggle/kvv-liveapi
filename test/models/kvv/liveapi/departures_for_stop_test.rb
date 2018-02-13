require 'test_helper'
require 'vcr'
require 'json'

describe KVV::Liveapi, :vcr do
  extend Minitest::Spec::DSL

  subject { KVV::Liveapi }

  let(:expected_timetable){ JSON.parse expectation_file( timetable_name )}

  describe "departures for stop by id" do

    let(:stop_id){'de:8212:401'}
    let(:unconnected_stop_id){'de:8212:25'}
    let(:timetable_name){ "kvv_departures_by_stop_id" }

    it "returns expected timetable" do
      refute_empty expected_timetable
      subject.departures_bystop( stop_id ).must_equal expected_timetable
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
    let(:timetable_name){ "kvv_departures_by_stop_name" }

    it "returns expected timetable" do
      subject.departures_bystop_name( stop_name ).must_equal expected_timetable
    end

    it "rescues empty stop name" do
      subject.departures_bystop_name( '' ).must_equal( {} )
    end

    it "rescues nil stop name" do
      subject.departures_bystop_name( nil ).must_equal( {} )
    end
  end

  describe "departures for route" do
    let(:route){ "3" }
    let(:stop_id){'de:8212:60'} # Karlsruhe Europaplatz, served by route 3
    let(:unserved_stop_id){'de:8212:401'} # Karlsruhe Kar-Wilhelm-Platz, not served by route 3
    let(:unconnected_stop_id){'de:8212:25'}
    let(:timetable_name){ "kvv_departures_by_route" }

    let(:unserved_timetable){ JSON.parse expectation_file("kvv_departures_for_unserved_stop_by_route") }


    it "returns expected timetable" do
      subject.departures_by_route(route: route, stop_id: stop_id).must_equal expected_timetable
    end

    it "rejects empty route" do
      subject.departures_by_route(route: nil, stop_id: stop_id).must_equal( {} )
    end

    it "rescues empty stop" do
      subject.departures_by_route(route: route, stop_id: nil).must_equal( {} )
    end

    it "rescues unserved stop name" do
      subject.departures_by_route(route: route, stop_id: unserved_stop_id).must_equal unserved_timetable
    end

    it "rescues unconnected stop name" do
      subject.departures_by_route(route: route, stop_id: unconnected_stop_id).must_equal( {} )
    end


  end

end
