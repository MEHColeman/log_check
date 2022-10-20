# New Project

Welcome to your new ruby project!

TODO: Delete this and describe your project.
TODO: Rename lib/empty_ruby_project
TODO: Delete bin/setup
TODO: If using guard, add 'watch(/^lib\/log_check\/(.+)\.rb/) { |m| "spec/#{m[1]}_spec.rb" }`

in an appropriate place.

## Installation

TODO: Write installation instructions here

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

### Make tasks
There are some commands set up in a Makefile to run various code quality
checks:
~~~
make secure    # run bundle audit to check for known vulnerabilities
make quality   # run rubycritic and simplecov
make fast      # run fasterer
make all       # all of the above
~~~

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/project


## License

This code is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
