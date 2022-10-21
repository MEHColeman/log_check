#frozen_string_literal: true

require 'log_check/validators/simple_validator'

## NullValidator validates each line.
# It DOES NOT validate the ip_address for valid format.
# Checks the whole line for two and only two values.
module LogCheck
  RSpec.describe SimpleValidator, '.line_validate!' do
    subject { SimpleValidator }

    let(:invalid_line_1) { '/test192.168.1.1' }
    let(:invalid_line_2) { '/test 192.168.1.1 s' }
    let(:valid_line) { '/test 999.999.999.999' }

    it 'rejects less than two strings separated by a space' do
      expect{subject.line_validate!(invalid_line_1)}.to raise_error RuntimeError
    end

    it 'rejects more than two strings separated by a space' do
      expect{subject.line_validate!(invalid_line_2)}.to raise_error RuntimeError
    end

    it 'allows exactly two strings' do
      expect{subject.line_validate!(valid_line)}.to_not raise_error
    end
  end

  RSpec.describe SimpleValidator, '.ip_valid?' do
    subject { SimpleValidator }

    let(:invalid_ip_address_1) { '/test 623.228.1.1' }
    let(:invalid_ip_address_2) { '/test 192.068.1.1' }
    let(:valid_ip_address) { '/test 191.68.1.1' }
    let(:not_an_ip_address) { '/test 192.abc.1.1' }

    it 'allows octets greater than 255' do
      expect(subject.ip_valid?(invalid_ip_address_1)).to be_truthy

    end

    it 'allows octets with leading 0s' do
      expect(subject.ip_valid?(invalid_ip_address_2)).to be_truthy

    end

    it 'allows valid IP addresses' do
      expect(subject.ip_valid?(valid_ip_address)).to be_truthy
    end

    it 'rejects strings that are definitely not IP addresses' do
      expect(subject.ip_valid?(not_an_ip_address)).to be_falsey
    end
  end
end
