#frozen_string_literal: true

require 'log_check/log_file_auditor'

## This Auditor tallies the total counts of valid log entries for each URL.
# A file location is required, and a Validator is implied. If none is supplied,
# SimpleValidator will be used.
module LogCheck
  RSpec.describe LogFileAuditor, '#count_total_views' do
    subject { LogFileAuditor.new(file_location: file_location) }

    context 'with a short example log file' do
      let(:file_location) { 'spec/fixtures/simple_test.log' }

      it 'returns a sorted array of addresses' do
        expect( subject.count_total_views ).to eq \
          [
            ['/help_page/1', 5],
            ['/test', 3],
            ['/help_page/2', 1]
          ]
      end

      context 'with a different Validator' do
        let(:strict_validator) { double('NoneValidator',
                                        'line_validate!' => true,
                                        'ip_valid?' => false ) }
        subject { LogFileAuditor.new(file_location: file_location,
                                     validator: strict_validator ) }

        it 'will count less lines' do
          expect( subject.count_total_views ).to eq []
        end
      end

      context 'with a different, short example log file' do
        let(:file_location) { 'spec/fixtures/other_test.log' }

        it 'returns a sorted hash of addresses' do
          expect( subject.count_total_views ).to eq \
            [
              ['/help_page/2', 4],
              ['/help_page/1', 3],
              ['/test', 2]
            ]
        end
      end

      context 'with a different, short example log file' do
        let(:file_location) { 'spec/fixtures/NON-EXISTANT-FILE.log' }

        it 'raises an exception' do
          expect{ subject.count_total_views }.to raise_error RuntimeError
        end
      end
    end
  end
end
