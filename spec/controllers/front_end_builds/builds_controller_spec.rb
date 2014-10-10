require 'rails_helper'

module FrontEndBuilds
  RSpec.describe BuildsController, :type => :controller do
    let(:app) { FactoryGirl.create :front_end_builds_app, name: 'dummy' }

    describe "index" do
      let!(:latest) do
        FactoryGirl.create :front_end_builds_build,
          app: app,
          sha: 'sha1',
          job: 'number1',
          branch: 'master',
          html: 'the newest build',
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
          html: 'an old build',
          fetched: true,
          active: true,
          created_at: 2.weeks.ago
      end

      it "should find the latest build" do
        get :index, app_name: app.name, branch: 'master'

        expect(response).to be_success
        expect(response.body).to match(latest.html)
      end

      it "should find the build by job" do
        get :index, app_name: app.name, job: 'number2'

        expect(response).to be_success
        expect(response.body).to match(older.html)
      end

      it "should have a csrf tag" do
        get :index, app_name: app.name, branch: 'master'
        expect(response).to be_success
        expect(response.body).to match(/csrf-token/)
      end

      it "should be 404 when nothing is found" do
        get :index, app_name: 'does-not-exist', branch: 'master'
        expect(response).to_not be_success
        expect(response.status).to eq(404)
      end
    end

    describe "create" do
      before(:each) do
        FactoryGirl.create :front_end_builds_build,
          app: app,
          created_at: 1.day.ago

        stub_request(
          :get,
          "ted.conferences.#{app.name}.s3-website-us-east-1.amazonaws.com/dist-1-some-sha/index.html"
        ).to_return(
          body: 'fetched html'
        )
      end

      it "should create the newest build" do
        post :create, {
          app_name: app.name,
          api_key: app.api_key,
          branch: 'master',
          sha: 'some-sha',
          job: '1',
        }

        expect(app.builds.find_best.html).to eq('fetched html')
      end

      it "should error if the api key does not match" do
        post :create, {
          app_name: app.name,
          api_key: 'a-bad-api-key',
          branch: 'master',
          sha: 'some-sha',
          job: '1',
        }

        expect(response).to_not be_success
      end

      it "should error if not all fields are present" do
        post :create, { app_name: app.name }
        expect(response).to_not be_success
      end
    end

  end
end
