require "bundler/setup"
#require "top10_local_day_care_centers"
require "http"
require 'pry'
require 'dotenv/load'

require "top10_local_day_care_centers/version"
require_relative "../lib/top10_local_day_care_centers/cli.rb"
require_relative "../lib/top10_local_day_care_centers/scraper.rb"
require_relative "../lib/top10_local_day_care_centers/center.rb"



module Top10LocalDayCareCenters
  class Error < StandardError; end
  # Your code goes here...
end
