#frozen_string_literal: true

require_relative 'validators/simple_validator'

module LogCheck
  class LogFileAuditor
    def initialize(file_location: ,
                   validator: SimpleValidator)
      @file_location = file_location
      @validator = validator
      @visits = Hash.new(0)
    end

    def count_total_views
      begin
        File.readlines(@file_location).each do |line|
          @validator.line_validate!(line)
          if @validator.ip_valid?(line)
            url, ip_address = line.split ' '
            @visits[url] += 1
          end
        end
      rescue SystemCallError => _file_error
        $stderr.puts 'File error. File must be present and readable'
        raise RuntimeError, 'File not read.'
      end
      @visits.sort_by { |url, visits| -visits }
    end
    def count_unique_views
      []
    end
  end
end
