#frozen_string_literal: true

require_relative 'validators/simple_validator'

## This Auditor will collate the information from the file whilst applying a
# validation filter. This collated visit data is memoised, so that it can be
# counted in two ways.
module LogCheck
  class LogFileAuditor
    def initialize(file_location: ,
                   validator: SimpleValidator)
      @file_location = file_location
      @validator = validator
    end

    def count_total_views
      collate_visits.
        map{|url, ip_visits| [url, ip_visits.
                              map{|ip, count| count}.
                              reduce(:+)]}.
      sort_by { |url, total_visits| -total_visits }
    end

    def count_unique_views
      collate_visits.
        map{|url, ip_visits| [url,ip_visits.count]}.
        sort_by { |url, unique_views| -unique_views }
    end

    private
    def collate_visits
      return @visits if @visits

      @visits = Hash.new { |h,k| h[k]= Hash.new(0) }
      begin
        File.readlines(@file_location).each do |line|
          @validator.line_validate!(line)
          if @validator.ip_valid?(line)
            url, ip_address = line.split ' '
            @visits[url][ip_address] += 1
          end
        end
      rescue SystemCallError => _file_error
        $stderr.puts 'File error. File must be present and readable'
        raise RuntimeError, 'File not read.'
      end
      @visits
    end
  end
end
