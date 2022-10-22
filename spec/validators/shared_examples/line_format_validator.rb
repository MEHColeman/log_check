#frozen_string_literal: true

# Checks the whole line for two and only two values, the second being 4 sets
# of digits.
module LogCheck
  RSpec.shared_examples 'a line format validator' do
    let(:invalid_line_1) { '/test192.168.1.1' }
    let(:invalid_line_2) { '/test 192.168.1.1 s' }
    let(:invalid_line_3) { 'Clone 99' }
    let(:valid_line) { '/test 999.999.999.999' }

    it 'rejects less than two strings separated by a space' do
      expect{subject.parse_data(invalid_line_1)}.to raise_error RuntimeError
    end

    it 'rejects more than two strings separated by a space' do
      expect{subject.parse_data(invalid_line_2)}.to raise_error RuntimeError
    end

    it 'rejects random strings not in the url/IP address format' do
      expect{subject.parse_data(invalid_line_3)}.to raise_error RuntimeError
    end

    it 'allows exactly two strings' do
      expect{subject.parse_data(valid_line)}.to_not raise_error
    end
  end
end
