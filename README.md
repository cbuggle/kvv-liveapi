# KVV::Liveapi

KVV::Liveapi is a simple ruby gem to query stop data and timetables / departures as provided by the KVV Live Service (Karlsruhe Transport Agency).

The KVV services is unofficial and undocumented so I can make no claims of any kind for this adapter to work as intended now or at any time in the future.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kvv-liveapi'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kvv-liveapi

## Usage

The KVV::Liveapi provides these 5 methods to query KVV data.

* KVV::Liveapi.departures_bystop_name( name )

* KVV::Liveapi.departures_bystop( stop_id )

* KVV::Liveapi.departures_by_route( route: nil, stop_id: nil )

* KVV::Liveapi.stops_by_name name

* KVV::Liveapi.stops_by_latlon( lat: nil, lon: nil )

The method names are derived closely from the corresponding liveapi.kvv.de api endpoints to assert consistency.


TODO: Explain details where not obvious

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/buggle/kvv-liveapi.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
