require 'rails_helper'

module FrontEndBuilds
  describe App, :type => :model do
    it { should have_many(:builds) }
    it { should validate_presence_of(:name) }

    describe "ensure_api_key!" do
      let(:app) { App.new(name: 'testing') }

      context "a new app" do
        subject { app.api_key }
        it { should be_nil }
      end

      context "a saved app" do
        before(:each) { app.save }
        subject { app.api_key }
        it { should_not be_nil }
      end
    end

    describe :find_best_build do
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
        subject { app.find_best_build(branch: 'master') }
        it { should eq(latest) }
      end

      context "when finding the job" do
        subject { app.find_best_build(job: 'number2') }
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

        subject { app.find_best_build(branch: 'master') }
        it { should eq(latest) }
      end

      context "when finding the sha" do
        subject { app.find_best_build(sha: 'sha2') }
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

        subject { app.find_best_build(branch: 'master') }
        it { should eq(latest) }
      end
    end
  end
end
