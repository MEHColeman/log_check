#frozen_string_literal: true

module LogCheck
  class LogFileAuditor
    def initialize(file_location: )
      @file_location = file_location
      @visits = Hash.new(0)
    end

    def count_total_views
      begin
        File.readlines(@file_location).each do |line|
          url, ip_address = line.split ' '
          @visits[url] += 1
        end
      rescue SystemCallError => _file_error
        $stderr.puts 'File error. File must be present and readable'
        raise RuntimeError, 'File not read.'
      end
      @visits.sort_by { |url, visits| -visits }
    end
  end
end
