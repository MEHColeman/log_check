# frozen_string_literal: true

# The executable script `parser.rb` takes one argument: filename and produces
# simple stats analysis information.

module LogCheck
  RSpec.describe 'executable script' do
    subject { `./parser.rb "#{log_file_location}"` }

    context 'with a short, well-formed example log file' do
      let(:log_file_location) { 'spec/fixtures/simple_test.log' }

      it 'outputs a correct view count' do
        expect(subject).to start_with(
          "/help_page/1 5 visits\n/test 3 visits\n/help_page/2 1 visits"
        )
      end
    end
  end
end
