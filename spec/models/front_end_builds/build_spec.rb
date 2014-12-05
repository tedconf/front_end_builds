require 'rails_helper'

module FrontEndBuilds
  RSpec.describe Build, :type => :model do

    it { should belong_to(:app) }

    it { should validate_presence_of(:app) }
    it { should validate_presence_of(:sha) }
    it { should validate_presence_of(:branch) }
    it { should validate_presence_of(:endpoint) }

    describe :find_best do
      let(:app) { FactoryGirl.create :front_end_builds_app }

      let!(:latest) do
        FactoryGirl.create :front_end_builds_build,
          app: app,
          sha: 'sha1',
          job: 'number1',
          branch: 'master',
          fetched: true,
          active: true,
          created_at: 1.day.ago
      end

      let!(:older) do
        FactoryGirl.create :front_end_builds_build,
          app: app,
          sha: 'sha2',
          job: 'number2',
          branch: 'master',
          fetched: true,
          active: true,
          created_at: 2.weeks.ago
      end

      context "when finding the branch" do
        subject { Build.find_best(app: app, branch: 'master') }
        it { should eq(latest) }
      end

      context "when finding the job" do
        subject { Build.find_best(app: app, job: 'number2') }
        it { should eq(older) }
      end

      context "when finding and active branch" do
        before(:each) do
          FactoryGirl.create :front_end_builds_build,
            app: app,
            sha: 'sha3',
            branch: 'master',
            fetched: true,
            active: false,
            created_at: 1.minute.ago
        end

        subject { Build.find_best(app: app, branch: 'master') }
        it { should eq(latest) }
      end

      context "when finding the sha" do
        subject { Build.find_best(app: app, sha: 'sha2') }
        it { should eq(older) }
      end

      context "when finding unfetched build" do
        before(:each) do
          FactoryGirl.create :front_end_builds_build,
            app: app,
            sha: 'sha3',
            branch: 'master',
            fetched: false,
            created_at: 1.minute.ago
        end

        subject { Build.find_best(app: app, branch: 'master') }
        it { should eq(latest) }
      end

      context "when finding another app" do
        before(:each) do
          FactoryGirl.create :front_end_builds_build,
            sha: 'sha4',
            branch: 'master',
            fetched: true,
            active: true,
            created_at: 1.minute.ago
        end

        subject { Build.find_best(app: app, branch: 'master') }
        it { should eq(latest) }
      end

      context "when finding the app by name" do
        subject { Build.find_best(app_name: app.name, branch: 'master') }
        it { should eq(latest) }
      end
    end

    describe :live? do
      let(:app) { FactoryGirl.create(:front_end_builds_app) }
      let!(:latest) do
        FactoryGirl.create :front_end_builds_build,
          app: app,
          sha: 'sha1',
          job: 'number1',
          branch: 'master',
          fetched: true,
          active: true,
          created_at: 1.day.ago
      end

      let!(:older) do
        FactoryGirl.create :front_end_builds_build,
          app: app,
          sha: 'sha2',
          job: 'number2',
          branch: 'master',
          fetched: true,
          active: true,
          created_at: 2.weeks.ago
      end

      it "should be live if it's the best" do
        expect(latest.live?).to be_truthy
      end

      it "should not be live the best if it's not the best" do
        expect(older.live?).to be_falsey
      end
    end 

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
