# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :front_end_builds_build, :class => 'FrontEndBuilds::Build' do
    sequence(:sha) { |n| "sha#{n}" }
    sequence(:job) { |n| n }
    sequence(:endpoint) { |n| "http://ted.bucket.ted.com/#{n}/index.html" }
    branch { "master" }
    signature { "some signature" }
    html { "hello world" }
    association :app, factory: :front_end_builds_app

    trait :fetched do
      fetched { true }
    end

    trait :live do
      after(:create) do |p|
        p.activate!
      end
    end

    trait :signed do
      after(:build) do |build|
        create_signature(build.app.name, build.endpoint)
      end
    end
  end
end
