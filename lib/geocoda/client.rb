module Geocoda

  class Client

    ##
    # Returns the default key
    def self.key
      @key ||= raise(MapKeyError, 'Missing Key: Geocoda::Client.key=(key)')
    end

    ##
    # Sets the default key
    def self.key=(key)
      @key = key
    end

    ##
    # Initialize the Client
    #
    # If the key is passed it will be used in place of the default key
    def initialize(key=nil)
      @key ||= self.class.key
      @http = Patron::Session.new
      @http.base_url = 'http://maps.google.com/maps/geo'
    end

    ##
    # Search for addresses that match a string
    #
    # @param [String] Address required for search
    # @return [Array<Address>] An array of addresses
    # @raise [StandardError] on errors
    def search(address)
      begin
        response = @http.get(hash_to_string(:q => address))
      rescue StandardError => e
        raise(ConnectionError, e.message)
      end
      unless response.status == 200
        raise(ConnectionError, "Response Code: #{response.status}")
      end
      Response.new(response.body).addresses
    end

    ##
    # Search for the first address that matches a string
    #
    # @see Geocoda::Client#search
    # @param [String] Address required for search
    # @return [Address] An address object
    # @raise [StandardError] on errors
    def first(address)
      search.first
    end

    private

    ##
    # Set the default parameters to use in searches
    def default_params
      {:key => @key, :gl => 'US', :output => 'json'}
    end

    ##
    # Convert a hash into a query parameter
    #
    # Example:
    # {:q => 'my address', :output => 'json'}
    # ?q=my%20address&output=json
    #
    # @return [String]
    def hash_to_string(hash)
      output = default_params.update(hash).map do |key, value|
        "#{key}=#{@http.escape(value.to_s)}"
      end.join("&")
      "?#{output}"
    end

  end

end