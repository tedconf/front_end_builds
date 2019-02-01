$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "front_end_builds/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "front_end_builds"
  s.version     = FrontEndBuilds::VERSION
  s.authors     = ["Ryan Toronto", "Sam Selikoff", "John Hirbour"]
  s.email       = ["rt@ted.com", "sam@ted.com", "gohn@ted.com"]
  s.homepage    = "http://github.com/tedconf/front_end_builds"
  s.summary     = "Summary of FrontEndBuilds."
  s.description = "Rails engine to manage front end builds and deployments"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib,public}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  # min supported version
  s.add_dependency 'rails', '~> 5.0'

  # Ideally we'd use this https://github.com/bensie/sshkey
  # for ssh key bits, but it doesn't support OpenSSL v2.x

  # sort this by alpha
  s.add_development_dependency 'bundler-audit'
  s.add_development_dependency 'byebug'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_bot_rails'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'pry-stack_explorer'
  s.add_development_dependency 'rb-readline'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'rspec-its'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'rubocop-rspec'
  s.add_development_dependency 'shoulda-matchers', '2.7.0'
  s.add_development_dependency "sqlite3"
  s.add_development_dependency 'webmock'
end
