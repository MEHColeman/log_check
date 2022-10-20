#frozen_string_literal: true

module LogCheck
  STRICT_LINE_MATCHER=/(?<url>^\/[(\d|\/|\w]+) (?<ip>(\d{1,3}).(\d{1,3}).(\d{1,3}).(\d{1,3}))$/
  class StrictValidator
    def self.line_validate!(line)
      fail RuntimeError, 'Logfile format error' unless line.match?(STRICT_LINE_MATCHER)
    end

    def self.ip_valid?(line)
      match = line.match(STRICT_LINE_MATCHER)
      if match
        ip = match[:ip]
        no_octet_is_gt_255(ip) && no_octet_has_leading_zeros(ip)
      else
        false
      end
    end

    private
    def self.no_octet_is_gt_255(ip)
      ip.split('.').map{|n| n.to_i<256}.reduce(:&)
    end

    def self.no_octet_has_leading_zeros(ip)
      ip.split('.').map{|n| n.length==1 || n[0]!='0'}.reduce(:&)
    end
  end
end
