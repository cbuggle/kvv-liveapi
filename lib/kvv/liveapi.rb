require 'uri'
require 'net/http'
require 'json'

module KVV
  class Liveapi
    API_KEY = '?key=377d840e54b59adbe53608ba1aad70e8'
    API_BASE = 'https://live.kvv.de/webapp/'

    URL_PATH_STOPS_BY_NAME = [ 'stops', 'byname']
    URL_PATH_DEPARTURES_BY_STOP = ['departures', 'bystop']
    URL_PATH_DEPARTURES_BY_LATLON = ['stops', 'bylatlon']
    URL_PATH_DEPARTURES_BY_ROUTE = ['departures', 'byroute']

    def self.departures_bystop_name name
      self.departures_bystop guess_stop_id_by_name(name)
    end

    def self.departures_bystop stop_id
      return {} unless stop_id
      fetch_api_path [URL_PATH_DEPARTURES_BY_STOP, stop_id]
    end

    def self.departures_by_route route: nil, stop_id: nil
      return {} unless route && stop_id
      fetch_api_path [URL_PATH_DEPARTURES_BY_ROUTE, route, stop_id]
    end

    def self.stops_by_name name
      return [] if name.to_s.empty?
      response = fetch_api_path [URL_PATH_STOPS_BY_NAME, name]
      response["stops"] || {}
    end

    def self.stops_by_latlon lat: nil, lon: nil
      return [] unless lat && lon
      response = fetch_api_path [URL_PATH_DEPARTURES_BY_LATLON, String(lat), String(lon)]
      response["stops"] || {}
    end

    private

    def self.fetch_api_path *path
      path = [ path ].flatten.map{ |p| CGI.escape p }.join("/")
      fetch [API_BASE, path , API_KEY].join
    end

    def self.fetch url
      uri = URI( url )
      request = Net::HTTP::Get.new(uri)

      req_options = {
        use_ssl: uri.scheme == "https",
      }

      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end

      case response.code
      when "200"
        JSON.parse(response.body)
      else
        {}
      end
    end

    def self.guess_stop_id_by_name name
      first_stop = stops_by_name(name).first
      first_stop["id"] unless first_stop.nil?
    end
  end
end
