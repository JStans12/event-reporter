require 'json'
require 'net/http'

class SunlightDistrict
  attr_accessor :district
  attr_reader :api_key

  def initialize(options)
    self.district = options["district"]
  end

  def self.api_key
    "253a5251ab7b42dbadbe3291b386bad6"
  end

  def self.by_zipcode(zipcode)
    uri = URI("http://congress.api.sunlightfoundation.com/districts/locate?zip=#{zipcode}&apikey=#{api_key}")
    new(JSON.load(Net::HTTP.get(uri))["results"].first)
  end
end
