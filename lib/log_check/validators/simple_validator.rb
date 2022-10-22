#frozen_string_literal: true

module LogCheck
  LINE_MATCHER=/(?<url>^\/[(\/|\w]+) (?<ip>(\d{1,3}).(\d{1,3}).(\d{1,3}).(\d{1,3}))$/

  ## SimpleValidator validates each line.
  # It DOES NOT validate the ip_address for valid octet values.
  # Checks the whole line for two and only two values, the second being 4 sets
  # of digits.
  class SimpleValidator
    def self.line_validate!(line)
      fail RuntimeError, 'Logfile format error' unless line.match?(LINE_MATCHER)
    end

    def self.ip_valid?(line)
      line.match?(LINE_MATCHER)
    end
  end
end
