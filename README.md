# Log Check

A simple script to count the number of views and unique views from a given
server log. An example log file can be found in `/resources/webserver.log`

Assumptions:
* Each line of the log is supposed to contain two fields, separated by a space.
* The first field represents the web page address.
* The second field represents an IP address. Validation of the correctness of
  the IP address is not required.
* A malformed line in the log file should be logged and rejected.
* All requests from the same IP address count as 1 unique view.

See NOTES.md for my development process notes.

## Installation

TODO: Write installation instructions here

## Usage

TODO: Write usage instructions here

## Development

`bundle exec guard` will automatically run tests as you work.

### Make tasks
There are some commands set up in a Makefile to run various code quality
checks:
~~~
make secure    # run bundle audit to check for known vulnerabilities
make quality   # run rubycritic and simplecov
make fast      # run fasterer
make all       # all of the above
~~~

## License

This code is available as open source under the terms of the [MIT
License](http://opensource.org/licenses/MIT).

