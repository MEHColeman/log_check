#frozen_string_literal: true

require 'log_check/log_check_printer'

# Outputs the stats for the provided log file.
# Raises an exception if the log file is not provided
# Useage: LogCheckPrinter.get_printer('file_path).output_total_views
module LogCheck
  RSpec.describe LogCheckPrinter, '.initialize' do
    it 'requires a log_file_analyser' do
      expect{LogCheckPrinter.new}.to raise_error ArgumentError
      expect{LogCheckPrinter.new(log_file_auditor: Object)}.to_not raise_error
    end
  end

  ## An object factory to hide implementation details from higher level
  # abstractions requires a file_location, and returns a LogCheckPrinter
  RSpec.describe LogCheckPrinter, '.get_printer' do
    it 'requires a file_location' do
      expect{LogCheckPrinter.get_printer}.to raise_error ArgumentError
      expect{LogCheckPrinter.get_printer(file_location: 'file.log')}.to_not raise_error
    end

    it 'returns a LogCheckPrinter' do
      expect(LogCheckPrinter.get_printer(
        file_location: 'file.log')).to be_a_kind_of LogCheckPrinter
    end
  end

  ## Takes an array of url/count pairs and prints them to stdout as per spec.
  RSpec.describe LogCheckPrinter, '#output_total_views' do

    subject { LogCheckPrinter.new(log_file_auditor:auditor) }
    let(:valid_results){ [
      ['/help_page/1', 5],
      ['/test', 3],
      ['/help_page/2', 1]
    ] }

    context 'with a correct audit log' do
      let(:auditor) { instance_double('LogFileAuditor', count_total_views: valid_results) }

      it 'outputs a correct view count' do
        expect{ subject.output_total_views }.to output(
          "/help_page/1 5 visits\n/test 3 visits\n/help_page/2 1 visits\n"
        ).to_stdout
      end

      it 'does not output anything to stderr' do
        expect { subject.output_total_views }.to_not output.to_stderr
      end

      end
    end
  end
