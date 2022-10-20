# frozen_string_literal: true

source 'https://rubygems.org'

group :test do
  gem 'rspec'
end

group :test, :development do
  # gem 'parallel_tests'
end

# include local gemfile
local_gemfile = File.join(File.dirname(__FILE__), 'Gemfile.local')
instance_eval(File.read(local_gemfile)) if File.readable?(local_gemfile)
