require 'rails_helper'

module FrontEndBuilds
  RSpec.describe Build, :type => :model do

    it { should belong_to(:app) }

    it { should validate_presence_of(:app) }
    it { should validate_presence_of(:sha) }
    it { should validate_presence_of(:branch) }
    it { should validate_presence_of(:endpoint) }

    describe :fetch! do
      let(:app) do
        FactoryGirl.create(:front_end_builds_app)
      end

      before(:each) do
        stub_request(
          :get,
          "www.ted.com/1/asdf"
        ).to_return(
          body: 'fetched html'
        )
      end

      it "should fetch and load the html" do
        build = FactoryGirl.create(:front_end_builds_build,
          app: app,
          job: 'job1',
          sha: 'sha1',
          endpoint: 'http://www.ted.com/1/asdf',
          fetched: false,
          html: ''
        )

        build.fetch!

        expect(build.html).to eq('fetched html')
      end

      it "should not fetch if it has already been fetched" do
        build = FactoryGirl.create :front_end_builds_build,
          html: 'unchanged',
          fetched: true

        build.fetch!

        expect(build.html).to eq('unchanged')
      end

    end

    describe :with_head_tag do
      let(:build) do
        FactoryGirl.create :front_end_builds_build,
          html: '<html><head></head></html>'
      end

      subject { build.with_head_tag('<title>test</title>') }
      it { should eq('<html><head><title>test</title></head></html>') }
    end

  end
end
