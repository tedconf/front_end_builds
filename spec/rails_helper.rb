ENV['RAILS_ENV'] ||= 'test'

require File.expand_path("../dummy/config/environment.rb",  __FILE__)

require 'rspec/rails'
require 'rspec/its'
require 'factory_bot_rails'
require 'shoulda/matchers'
require 'webmock/rspec'
require 'database_cleaner'

Rails.backtrace_cleaner.remove_silencers!

if Rails::VERSION::MAJOR >= 4 && Rails::VERSION::MINOR >= 1
  ActiveRecord::Migration.maintain_test_schema!
end

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
  config.include JsonParser, type: :controller
  config.include JsonParser, type: :request
  config.include CreateSignature

  # make create & build available directly.
  # FactoryBot.create(:foo) -> create(:foo)
  config.include FactoryBot::Syntax::Methods
end
