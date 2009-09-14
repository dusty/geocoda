== DESCRIPTION:

Used to interact with Googles Geocoding API


== REQUIREMENTS:

patron
json


== INSTALL:

$ gem build geocoder.gemspec
$ sudo gem install geocoder-x.x.x.gem


== USAGE:

Geocoder.search('123 My St, MyCity, NY')
 # returns an array of addresses or throws an exception
 
Geocoder.first('123 My St, MyCity, NY')
 # returns a single address or throws an exception
 
See Geocoder::Response.check_status for errors thrown depending on the results
Errors in the HTTP call throw a Geocoder::ConnectionError

Your google API key is required.  You may set this in one of two ways.

1. Set the class variable with Geocoder::Client.key = 'xxxxxx'
 $ Geocoder.search('My Address') # uses default key
 
2. Send the key with your searches
 $ Geocoder.search('My Address', key) # uses defined key
 
