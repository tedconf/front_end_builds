source "https://rubygems.org"

gemspec

rails_version = ENV['RAILS_VERSION'] || 'default'

rails = case rails_version
when 'master'
  { :github => 'rails/rails'}
when 'default'
  '~> 6'
else
  "~> #{rails_version}"
end

gem 'rails', rails


 # these are here so travis will work
group :test, :development do
  gem 'sqlite3'
end
