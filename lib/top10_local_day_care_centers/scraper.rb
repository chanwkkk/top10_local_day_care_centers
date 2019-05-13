require "json"
require "http"
require 'pry'







module Top10LocalDayCareCenters
  class Scraper

     def self.scrape_from_zip(zip)
        businesses=Scraper.search(term="day care",zip)["businesses"]
        all_business=[]
        businesses.each do |business|
           center=Center.new
  #binding.pry
          center.id=business["id"]
          center.name=business["name"]
          center.address=business["location"]["display_address"][0]
          center.rating=business["rating"]
          center.url=business["url"]
          center.zip=business["location"]["zip_code"]
          center.phone_number=business["display_phone"]
          all_business<<center
        end

        all_business
     end




     # Place holders for Yelp Fusion's API key. Grab it
     # from https://www.yelp.com/developers/v3/manage_app
     API_KEY = "MJEH8ky-Ny4riDUbkRNhjiTIWYe6cZ2Hn-czwKppVnB1QcTdX4D0Z630AebMwutNYk1l5nY6NHK4YhtBH281NZCOOFpNtaQHAAUOjcn74YgkFmGQS42no5PCzojUXHYx"


     # Constants, do not change these
     API_HOST = "https://api.yelp.com"
     SEARCH_PATH = "/v3/businesses/search"
     BUSINESS_PATH = "/v3/businesses/"  # trailing / because we append the business id to the path


     #DEFAULT_BUSINESS_ID = "yelp-san-francisco"
    # DEFAULT_TERM = "dinner"
     #DEFAULT_LOCATION = "San Francisco, CA"
     SEARCH_LIMIT = 10
     RATING="rating"


     # Make a request to the Fusion search endpoint. Full documentation is online at:
     # https://www.yelp.com/developers/documentation/v3/business_search
     #
     # term - search term used to find businesses
     # location - what geographic location the search should happen
     #
     # Examples
     #
     #   search("burrito", "san francisco")
     #   # => {
     #          "total": 1000000,
     #          "businesses": [
     #            "name": "El Farolito"
     #            ...
     #          ]
     #        }
     #
     #   search("sea food", "Seattle")
     #   # => {
     #          "total": 1432,
     #          "businesses": [
     #            "name": "Taylor Shellfish Farms"
     #            ...
     #          ]
     #        }
     #
     # Returns a parsed json object of the request
     def self.search(term, location)
       url = "#{API_HOST}#{SEARCH_PATH}"
       params = {
         term: term,
         location: location,
         limit: SEARCH_LIMIT
         #sort_by: Rating

       }

       response = HTTP.auth("Bearer #{API_KEY}").get(url, params: params)
       response.parse
     end
  end
end
