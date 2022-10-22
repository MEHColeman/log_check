#frozen_string_literal: true

require_relative 'simple_validator'

module LogCheck
  ## StrictValidator parses and validates each line.
  # It DOES validate the ip_address for valid format and valid octet values.
  # Checks the whole line for two and only two values, the second being 4 sets
  # of digits.
  class StrictValidator < SimpleValidator
    def self.parse_data(line)
      _, url, ip_address = super

      [
        no_octet_is_gt_255(ip_address) && no_octet_has_leading_zeros(ip_address),
        url,
        ip_address
      ]
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
