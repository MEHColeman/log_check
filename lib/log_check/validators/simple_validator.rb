#frozen_string_literal: true

module LogCheck
  LINE_MATCHER=/(?<url>^\/[\/|\w]+) (?<ip>(\d{1,3}).(\d{1,3}).(\d{1,3}).(\d{1,3}))$/

  ## SimpleValidator parses and validates each line. Parse and Validation are
  # basically the same thing, so it's just one method.
  # It DOES NOT validate the ip_address for valid octet values.
  # Checks the whole line for two and only two values, the second being 4 sets
  # of digits.
  class SimpleValidator
    def self.parse_data(line)
      match = line.match(LINE_MATCHER)
      fail RuntimeError, 'Logfile format error' unless match

      [true, match[:url], match[:ip]]
    end
  end
end
