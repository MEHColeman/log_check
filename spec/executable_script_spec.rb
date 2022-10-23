# frozen_string_literal: true

require 'support/output_matcher'

# The executable script `parser.rb` takes one argument: filename and produces
# simple stats analysis information.
# An error message and usage information is displayed if no file is specified.
# Only valid IP addresses are considered if the `--strict` option is given.

module LogCheck
  RSpec.describe 'executable script' do
    subject { system("./parser.rb #{optional_args} #{log_file_location}") }
    let(:optional_args) { '' }

    context 'with a short example log file' do
      let(:log_file_location) { 'spec/fixtures/simple_test.log' }

      it 'outputs a correct view count' do
        expect{subject}.to send_to_stdout(
          "/help_page/1 5 visits\n/test 3 visits\n/help_page/2 1 visits")
      end

      it 'outputs a correct unique view count' do
        expect{subject}.to send_to_stdout(
          "/help_page/1 4 unique views\n/test 1 unique views\n/help_page/2 1 unique views")
      end
    end

    context 'without a log file given' do
      let(:log_file_location) { '' }

      it 'outputs usage information' do
        expect{subject}.to send_to_stdout("Usage:")
      end

      it 'exits with a non-zero return code' do
        expect(subject).to be_falsey
      end
    end

    context 'with an invalid log file given' do
      let(:log_file_location) { '/does/not/exist.log' }

      it 'sends a message to stderr' do
        expect{subject}.to send_to_stderr("File error. File must be present and readable")
      end
    end

    context 'when passed the --strict option' do
      let(:optional_args) { '--strict ' }

      context 'when the file has some valid IP addresses' do
        let(:log_file_location) { 'spec/fixtures/bad_ip_ranges_test.log' }

        it 'outputs a correct, validated view count' do
          expect{subject}.to send_to_stdout(
            "/help_page/1 4 visits\n/test 1 visits")
        end

        it 'outputs a correct, validated unique visit count' do
          expect{subject}.to send_to_stdout(
            "/help_page/1 3 unique views\n/test 1 unique views")
        end
      end

      context 'when the file has no valid IP addresses' do
        let(:log_file_location) { 'spec/fixtures/simple_test.log' }

        it 'outputs no text, if the validated view count is 0' do
          expect{subject}.to send_to_stdout("\n")
        end
      end
    end
  end
end
