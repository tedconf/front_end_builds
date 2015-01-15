# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :front_end_builds_build, :class => 'FrontEndBuilds::Build' do
    sequence(:sha) { |n| "sha#{n}" }
    sequence(:job) { |n| n }
    sequence(:endpoint) { |n| "http://ted.bucket.ted.com/#{n}/index.html" }
    branch "master"
    html "hello world"
    association :app, factory: :front_end_builds_app

    trait :fetched do
      fetched true
    end

    trait :active do
      active true
    end
  end
end
