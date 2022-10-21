# frozen_string_literal: true

require_relative 'log_file_auditor'
require_relative 'validators/simple_validator'
require_relative 'validators/strict_validator'

module LogCheck
  # Outputs the stats for the provided log file.
  # Raises an exception if the log file is not provided
  # Useage: LogCheckPrinter.get_printer('file_path).output_total_views
  class LogCheckPrinter
    def self.get_printer(file_location: , strict: false)
      validator = strict ? StrictValidator : SimpleValidator
      LogCheckPrinter.new(
        log_file_auditor: LogFileAuditor.new(
          file_location: file_location,
          validator: validator)
      )
    end

    def initialize(log_file_auditor: )
      @log_file_auditor = log_file_auditor
    end

    def output_total_views
      output_decorated_views(counts: @log_file_auditor.count_total_views,
                             text_decoration: " visits")
    end
    def output_unique_views
      output_decorated_views(counts: @log_file_auditor.count_unique_views,
                             text_decoration: " unique views")
    end

    private
    def output_decorated_views(counts: , text_decoration:)
      counts.each do | tuple |
        puts "#{tuple[0]} #{tuple[1]}#{text_decoration}"
      end
    end
  end
end
