source "https://rubygems.org"

gemspec

rails_version = ENV['RAILS_VERSION'] || 'default'

rails = case rails_version
when 'master'
  { :github => 'rails/rails'}
when 'default'
  '~> 3.2.0'
else
  "~> #{rails_version}"
end

gem 'rails', rails

if rails[3] == "3"
  gem 'strong_parameters'
end
