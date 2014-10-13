# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :front_end_builds_build, :class => 'FrontEndBuilds::Build' do
    sequence(:sha) { |n| "sha#{n}" }
    sequence(:job) { |n| n }
    branch "master"
    html "hello world"
    association :app, factory: :front_end_builds_app
  end
end
