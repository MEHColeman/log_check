# frozen_string_literal: true

require_relative 'log_file_auditor'

module LogCheck
  class LogCheckPrinter
    def self.get_printer(file_location:)
      LogCheckPrinter.new(
        log_file_auditor: LogFileAuditor.new(file_location: file_location)
      )
    end

    def initialize(log_file_auditor: )
      @log_file_auditor = log_file_auditor
    end

    def output_total_views
      @log_file_auditor.count_total_views.each do | tuple |
        puts "#{tuple[0]} #{tuple[1]} visits"
      end
    end
  end
end
