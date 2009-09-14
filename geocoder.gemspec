Gem::Specification.new do |s| 
  s.name = "geocoder" 
  s.version = "0.0.1" 
  s.author = "Dusty Doris" 
  s.email = "github@dusty.name" 
  s.homepage = "http://code.dusty.name"
  s.platform = Gem::Platform::RUBY 
  s.summary = "Interface to Google's Geocoder API" 
  s.files = Dir["{test,lib}/**/*"]
  s.require_path = "lib" 
  s.has_rdoc = true 
  s.extra_rdoc_files = ["README.txt"]
  s.add_dependency('json_pure')
  s.add_dependency('patron')
  s.rubyforge_project = "none"
end
