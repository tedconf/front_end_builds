require 'rails_helper'

module FrontEndBuilds
  RSpec.describe Build, :type => :model do

    it { should belong_to(:app) }
    it { should belong_to(:pubkey) }

    it { should validate_presence_of(:app) }
    it { should validate_presence_of(:sha) }
    it { should validate_presence_of(:branch) }

    describe :find_best do
      let(:app) { FactoryGirl.create :front_end_builds_app }

      let!(:latest) do
        FactoryGirl.create :front_end_builds_build,
          app: app,
          sha: 'sha1',
          job: 'number1',
          branch: 'master',
          fetched: true,
          created_at: 1.day.ago
      end

      let!(:live_build) do
        FactoryGirl.create :front_end_builds_build, :live,
          app: app,
          sha: 'sha2',
          job: 'number2',
          branch: 'anything',
          fetched: true,
          created_at: 1.week.ago
      end

      let!(:older) do
        FactoryGirl.create :front_end_builds_build,
          app: app,
          sha: 'sha3',
          job: 'number3',
          branch: 'master',
          fetched: true,
          created_at: 2.weeks.ago
      end

      context "with no query" do
        before(:each) do
          FactoryGirl.create :front_end_builds_build,
            app: app,
            sha: 'sha4',
            branch: 'nonmaster',
            fetched: true,
            created_at: 2.days.ago
        end

        subject { Build.find_best(app: app) }
        it { should eq(live_build) }
      end

      context "when finding the id" do
        subject { Build.find_best(id: older.id) }
        it { should eq(older) }
      end

      context "when finding the branch" do
        before(:each) do
          FactoryGirl.create :front_end_builds_build,
            app: app,
            sha: 'sha3',
            branch: 'master',
            fetched: true,
            created_at: 2.days.ago
        end

        subject { Build.find_best(app: app, branch: 'master') }
        it { should eq(latest) }
      end

      context "when finding the job" do
        subject { Build.find_best(app: app, job: 'number3') }
        it { should eq(older) }
      end

      context "when finding the sha" do
        subject { Build.find_best(app: app, sha: 'sha3') }
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

    describe '#verify' do
      let(:app) { FactoryGirl.create(:front_end_builds_app, name: 'app') }
      let(:endpoint) { 'http://some.external.url.ted.com/index.html' }

      let(:build) do
        FactoryGirl.build(:front_end_builds_build, {
          app: app,
          endpoint: endpoint,
          signature: create_signature("#{app.name}-#{endpoint}")
        })
      end

      let(:ssh_pubkey) do
        File.read(Rails.root.join('..', 'fixtures', 'id_rsa.pub'))
      end

      it 'should be true if the signature can be verifed by a pubkey' do
        FactoryGirl.create(:front_end_builds_pubkey, {
          pubkey: ssh_pubkey
        })

        expect(build.verify).to be_truthy
      end

      it 'should not be true if the signature cannot be veriried' do
        expect(build.verify).to be_falsey
      end
    end

    describe '#matching_pubkey' do
      let(:app) { FactoryGirl.create(:front_end_builds_app, name: 'app') }
      let(:endpoint) { 'http://some.external.url.ted.com/index.html' }

      let(:build) do
        FactoryGirl.build(:front_end_builds_build, {
          app: app,
          endpoint: endpoint,
          signature: create_signature("#{app.name}-#{endpoint}")
        })
      end

      let(:ssh_pubkey) do
        File.read(Rails.root.join('..', 'fixtures', 'id_rsa.pub'))
      end

      it 'should have a pubkey if the signature can be verifed by a pubkey' do
        pubkey = FactoryGirl.create(:front_end_builds_pubkey, {
          pubkey: ssh_pubkey
        })

        expect(build.matching_pubkey).to eq(pubkey)
      end

      it 'should not have a pubkey if the signature cannot be veriried' do
        expect(build.matching_pubkey).to be_nil
      end
    end

    describe :live? do
      let(:app) { FactoryGirl.create(:front_end_builds_app) }
      let!(:latest) do
        FactoryGirl.create :front_end_builds_build, :live,
          app: app,
          sha: 'sha1',
          job: 'number1',
          branch: 'master',
          fetched: true,
          created_at: 1.day.ago
      end

      let!(:older) do
        FactoryGirl.create :front_end_builds_build,
          app: app,
          sha: 'sha2',
          job: 'number2',
          branch: 'master',
          fetched: true,
          created_at: 2.weeks.ago
      end

      it "should be live if it's the live build" do
        expect(latest.live?).to be_truthy
      end

      it "should not be live if it's not the live build" do
        expect(older.live?).to be_falsey
      end
    end

    describe :master? do
      let(:app) { FactoryGirl.create(:front_end_builds_app) }
      let(:build1) do
        FactoryGirl.create :front_end_builds_build,
          app: app,
          branch: 'master'
      end
      let(:build2) do
        FactoryGirl.create :front_end_builds_build,
          app: app,
          branch: 'feature'
      end

      it "should be truthy if the branch is 'master'" do
        expect(build1.master?).to be_truthy
      end

      it "should be false if the branch is not 'master'" do
        expect(build2.master?).to be_falsey
      end
    end

    describe '#setup!' do
      let(:build) do
        FactoryGirl.create(:front_end_builds_build)
      end

      before(:each) do
        allow(build).to receive(:fetch!)
        allow(build).to receive(:automatic_activiation?)
        allow(build).to receive(:master?)
      end

      it 'should fetch the new build' do
        build.html = ''
        build.fetched = false
        build.save

        expect(build).to receive(:fetch!)
        build.setup!
      end

      it 'should not fetch if the build already has html' do
        expect(build).to_not receive(:fetch!)
        build.update_attributes(html: 'got it')
        build.setup!
      end

      it 'should autoamtically activate a master/automatic activation build' do
        expect(build).to receive(:automatic_activation?).and_return(true)
        expect(build).to receive(:master?).and_return(true)
        expect(build).to receive(:activate!)

        build.setup!
      end

      it 'should not active the build if it is not master' do
        expect(build).to receive(:automatic_activation?).and_return(true)
        expect(build).to receive(:master?).and_return(false)
        expect(build).to_not receive(:activate!)

        build.setup!
      end

      it 'should not activate the build if it does not have automatic activiation' do
        expect(build).to receive(:automatic_activation?).and_return(false)
        expect(build).to_not receive(:activate!)

        build.setup!
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
