Gem::Specification.new do |s|
  s.name = "geocoda"
  s.version = "0.0.4"
  s.author = "Dusty Doris"
  s.email = "github@dusty.name"
  s.homepage = "https://github.com/dusty/geocoda"
  s.platform = Gem::Platform::RUBY
  s.summary = "Interface to Google's Geocoder API"
  s.files = %w[
    README.txt
    lib/geocoda.rb
    lib/geocoda/client.rb
    lib/geocoda/response.rb
  ]
  s.require_path = "lib"
  s.has_rdoc = true
  s.extra_rdoc_files = ["README.txt"]
  s.add_dependency('json')
  s.add_dependency('net-http-persistent')
  s.rubyforge_project = "none"
end
