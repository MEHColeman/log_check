#frozen_string_literal: true

require 'rspec/expectations'

RSpec::Matchers.define 'send_to_stdout' do |expected|
  match do |actual|
    expect{actual.call}.to output(a_string_including(expected)).to_stdout_from_any_process
  end

  supports_block_expectations
end

RSpec::Matchers.define 'send_to_stderr' do |expected|
  match do |actual|
    expect{actual.call}.to output(a_string_including(expected)).to_stderr_from_any_process
  end

  supports_block_expectations
end
