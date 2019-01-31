FactoryBot.define do
  factory :front_end_builds_pubkey, :class => 'FrontEndBuilds::Pubkey' do
    name { 'ryan' }
    sequence(:pubkey) { |i| "ssh-rsa pubkey#{i}#{i}#{i} test@ted.com" }

    trait :fixture_pubkey do
      pubkey do
       File.read(Rails.root.join('..', 'fixtures', 'id_rsa.pub'))
      end
    end
  end
end
