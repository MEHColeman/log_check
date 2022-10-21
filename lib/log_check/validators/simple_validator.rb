#frozen_string_literal: true

module LogCheck
  SIMPLE_LINE_MATCHER=/(?<url>^\/[(\/|\w]+) (?<ip>(\d{1,3}).(\d{1,3}).(\d{1,3}).(\d{1,3}))$/

  ## SimpleValidator validates each line.
  # It DOES NOT validate the ip_address for valid format.
  # Checks the whole line for two and only two values.
  class SimpleValidator
    def self.line_validate!(line)
      fail RuntimeError, 'Logfile format error' unless line.match?(SIMPLE_LINE_MATCHER)
    end

    def self.ip_valid?(line)
      line.match?(SIMPLE_LINE_MATCHER)
    end
  end
end
