== DESCRIPTION:

Used to interact with Googles Geocoding API


== REQUIREMENTS:

patron
json


== INSTALL:

$ gem build geocoda.gemspec
$ sudo gem install geocoda-x.x.x.gem


== USAGE:

Geocoda.search('123 My St, MyCity, NY')
 # returns an array of addresses or throws an exception

Geocoda.first('123 My St, MyCity, NY')
 # returns a single address or throws an exception

See Geocoda::Response.check_status for errors thrown depending on the results
Errors in the HTTP call throw a Geocoda::ConnectionError

Your google API key is required.  You may set this in one of two ways.

1. Set the class variable with Geocoda::Client.key = 'xxxxxx'
 $ Geocoda.search('My Address') # uses default key

2. Send the key with your searches
 $ Geocoda.search('My Address', key) # uses defined key

