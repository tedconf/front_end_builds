# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :front_end_builds_app, :class => 'FrontEndBuilds::App' do
    sequence(:name) { |n| "application-#{n}" }
  end
end
