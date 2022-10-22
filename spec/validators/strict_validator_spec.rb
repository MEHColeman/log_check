#frozen_string_literal: true

require 'log_check/validators/strict_validator'

## StrictValidator parses and validates each line.
# It DOES validate the ip_address for valid format and valid octet values.
# Checks the whole line for two and only two values, the second being 4 sets
# of digits.
module LogCheck
  RSpec.describe StrictValidator, 'line parsing and IP address validation' do
    subject { StrictValidator }

    let(:invalid_ip_address_1) { '/test 623.228.1.1' }
    let(:invalid_ip_address_2) { '/test 192.068.1.1' }
    let(:valid_ip_address) { '/test 191.68.0.1' }
    let(:not_an_ip_address) { '/test 192.abc.1.1' }

    it 'rejects octets greater than 255' do
      expect(subject.parse_data(invalid_ip_address_1)).to be
      [ false, '/test', '623.228.1.1' ]
    end

    it 'rejects octets with leading 0s' do
      expect(subject.parse_data(invalid_ip_address_2)).to be
      [ false, '/test', '192.068.1.1' ]
    end

    it 'allows valid IP addresses' do
      expect(subject.parse_data(valid_ip_address)).to be
      [ true, '/test', '191.68.1.1' ]
    end

    it 'raises an error when strings are definitely not IP addresses' do
      expect{subject.parse_data(not_an_ip_address)}.to raise_error RuntimeError
    end
  end
end
