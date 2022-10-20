#!/usr/bin/env ruby

require_relative 'lib/log_check/log_check_printer'
require 'optparse'

options = {}
option_parser = OptionParser.new do |opts|
  opts.on('--strict', 'Only count valid IP addresses') do |b|
    options[:strict] = true
  end
end

option_parser.banner = 'Usage: parser.rb [options] filename'
option_parser.parse!

file = ARGV[0]
begin
  LogCheck::LogCheckPrinter.get_printer(file_location: file,
                                        strict: options[:strict]).output_total_views
rescue
  puts option_parser
  exit 1
end
