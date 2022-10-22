#frozen_string_literal: true

require_relative 'simple_validator'

module LogCheck
  ## StrictValidator validates each line.
  # It DOES validate the ip_address for valid format.
  # Checks the whole line for two and only two values.
  class StrictValidator < SimpleValidator
    def self.line_validate!(line)
      super
    end

    def self.ip_valid?(line)
      match = line.match(LINE_MATCHER)
      return false unless match

      ip = match[:ip]
      no_octet_is_gt_255(ip) && no_octet_has_leading_zeros(ip)
    end

    private
    def self.no_octet_is_gt_255(ip)
      ip.split('.').map{|n| n.to_i < 256}.reduce(:&)
    end

    def self.no_octet_has_leading_zeros(ip)
      ip.split('.').map{|n| n.length == 1 || n[0]!='0'}.reduce(:&)
    end
  end
end
