$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "front_end_builds/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "front_end_builds"
  s.version     = FrontEndBuilds::VERSION
  s.authors     = ["Ryan Toronto"]
  s.email       = ["rt@ted.com"]
  s.homepage    = "http://github.com/tedconf/front_end_builds"
  s.summary     = "Summary of FrontEndBuilds."
  s.description = "Description of FrontEndBuilds."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'active_model_serializers', '~> 0.8.1.0'

  s.add_development_dependency "sqlite3"
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'pry-stack_explorer'
  s.add_development_dependency 'shoulda-matchers'
  s.add_development_dependency 'webmock'
end
