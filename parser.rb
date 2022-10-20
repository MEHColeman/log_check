#!/usr/bin/env ruby

require_relative 'lib/log_check/log_check_printer'

file = ARGV[0]
begin
  LogCheck::LogCheckPrinter.get_printer(file_location: file).output_total_views
rescue
  exit 1
end

