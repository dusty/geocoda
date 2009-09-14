module Geocoder
  
  class Response
    attr_reader :json
    
    ##
    # Initialize the response and check for errors in the Status code
    #
    # @see check_status
    # @raise [StandardError]
    def initialize(json)
      @json = json
      @hash = JSON.parse(json)
      check_status
    end

    ##
    # Return an array of addresses that matched the search
    #
    # @return [Array<Address>]
    def addresses
      @addresses ||= @hash["Placemark"].map {|place| Address.new(place)}
    end
    
    ##
    # Check the status returned by Google and throw exception on
    # results that are not 200
    #
    # @raise [StandardError]
    def check_status
      case @hash["Status"]["code"]
      when 200 then
        true
      when 500
        raise ServerError, "Unknown server error"
      when 601
        raise MissingAddressError, "Missing address"
      when 602
        raise UnknownAddressError, "Unknown address"
      when 603
        raise UnavailableAddressError, "Unavailable address"
      when 610
        raise InvalidMapKeyError, "Invalid map key"
      when 620
        raise TooManyQueriesError, "Too many queries for map key"
      else
        raise UnknownError, "Unknown error: #{@hash['code']}"
      end
    end

  end
  
  class Address
    ##
    # Initialize class
    #
    # set @hash to the json parsed hash
    def initialize(hash)
      @hash = hash
    end
    
    ##
    # Address
    #
    # @return [String] address
    def address
      @address ||= @hash["address"]
    end
    
    ##
    # Street
    #
    # @return [String] street
    def street
      @street ||= @hash["AddressDetails"]["Country"]["AdministrativeArea"]\
                       ["Locality"]["Thoroughfare"]["ThoroughfareName"]
    end
    
    ##
    # City
    #
    # @return [String] city
    def city
     @city ||= @hash["AddressDetails"]["Country"]["AdministrativeArea"]\
                    ["Locality"]["LocalityName"]
    end
    
    ##
    # State
    #
    # @return [String] state
    def state
      @state ||= @hash["AddressDetails"]["Country"]["AdministrativeArea"]\
                      ["AdministrativeAreaName"]
    end
    
    ##
    # Zipcode
    #
    # @return [String] zipcode
    def zipcode
      @zipcode ||= @hash["AddressDetails"]["Country"]["AdministrativeArea"]\
                        ["Locality"]["PostalCode"]["PostalCodeNumber"]
    end
    
    ##
    # Country
    #
    # @return [String] country
    def country
      @country ||= @hash["AddressDetails"]["Country"]["CountryNameCode"]
    end
    
    ##
    # Accuracy
    #
    # Convert Googles Accuracy integer into a word describing how accurate
    # the match is
    #
    # @see accuracy_map
    # @return [String] accuracy
    def accuracy
      @accuracy ||= accuracy_map[@hash["AddressDetails"]["Accuracy"].to_i]
    end
    
    ##
    # Coordinates
    #
    # An array of coordinates in the form of [lat, lng, elevation]
    #
    # @return [<Array>] lat, lng, elevation
    def coordinates
      @coordinates ||= [lat, lng, elevation]
    end
    
    ##
    # Lat
    #
    # @return [Float] latitude
    def lat
      @lat ||= @hash["Point"]["coordinates"][0].to_f
    end
    
    ##
    # Lng
    #
    # @return [Float] longitude
    def lng
      @lng ||= @hash["Point"]["coordinates"][1].to_f
    end
    
    ##
    # Elevation
    #
    # @return [Float] elevation
    def elevation
      @elevation ||= @hash["Point"]["coordinates"][2].to_f
    end
    
    private
    
    ##
    # Map Googles code to a user friendly word
    #
    # @return [String]
    def accuracy_map
      %w{ unknown country state county city zip zip+4 street address }
    end
  end
end