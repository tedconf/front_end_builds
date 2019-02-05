source "https://rubygems.org"

gemspec

rails_version = ENV['RAILS_VERSION'] || 'default'

rails = case rails_version
when 'master'
  { :github => 'rails/rails'}
when 'default'
  '~> 5.0.4'
else
  "~> #{rails_version}"
end

gem 'rails', rails


 # there are here for travis
group :test, :development do
  gem 'sqlite3', '< 1.4'
end
