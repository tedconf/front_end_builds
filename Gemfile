source "https://rubygems.org"

gemspec

rails_version = ENV['RAILS_VERSION'] || 'default'

rails = case rails_version
when 'master'
  { :github => 'rails/rails'}
when 'default'
  '~> 4.2.0'
else
  "~> #{rails_version}"
end

gem 'rails', rails

# These no longer ship with ruby 2.2.0, but are needed for
# Rails 3 and 4.0.0
if RUBY_VERSION == "2.2.0"
  gem 'test-unit'
  gem 'minitest'
end
