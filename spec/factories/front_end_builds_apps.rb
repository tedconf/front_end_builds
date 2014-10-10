# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :front_end_builds_app, :class => 'FrontEndBuilds::App' do
    sequence(:name) { |n| "application-#{n}" }
    sequence(:api_key) { |n| "api-key-#{n}" }
  end
end
