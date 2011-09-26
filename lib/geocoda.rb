require 'net/http/persistent'
require 'json'
require 'uri'

$LOAD_PATH << "./lib"
require 'geocoda/client'
require 'geocoda/response'

module Geocoda

  class Error < StandardError; end
  class ServerError  < Error; end
  class AddressError < Error; end
  class MissingAddressError     < AddressError; end
  class UnknownAddressError     < AddressError; end
  class UnavailableAddressError < AddressError; end
  class MapKeyError < Error; end
  class InvalidMapKeyError  < MapKeyError; end
  class TooManyQueriesError < MapKeyError; end
  class UnknownError < Error; end
  class ConnectionError < Error; end

  ##
  # The current version of the application
  def self.version
    "0.0.4"
  end

  ##
  # Search for addresses that match a string
  #
  # @see Geocoda::Client#search
  def self.search(address,key=nil)
    Client.new(key).search(address)
  end

  ##
  # Search for the first address that matches a string
  #
  # @see Geocoda::Client#first
  def self.first(address,key=nil)
    search(address,key).first
  end

end