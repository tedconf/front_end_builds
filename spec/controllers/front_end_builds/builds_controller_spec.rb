require 'rails_helper'

module FrontEndBuilds
  RSpec.describe BuildsController, :type => :controller do
    let(:app) { FactoryGirl.create :front_end_builds_app, name: 'dummy' }

    describe "index" do
      routes { FrontEndBuilds::Engine.routes }

      it "should list all the builds for an app" do
        FactoryGirl.create_list(:front_end_builds_build, 3, app: app)

        get :index, app_id: app.id, format: :json
        expect(response).to be_success
        expect(json['builds'].length).to eq(3)
      end

      it 'should be scoped to the requested app' do
        build1 = FactoryGirl.create(:front_end_builds_build, app: app)
        FactoryGirl.create(:front_end_builds_build)

        get :index, app_id: app.id, format: :json
        expect(response).to be_success
        expect(json['builds'].length).to eq(1)
        expect(json['builds'].first['id']).to eq(build1.id)
      end

      it "should not list any builds if the app is not present" do
        FactoryGirl.create_list(:front_end_builds_build, 3)

        get :index, format: :json
        expect(response).to be_success
        expect(json['builds'].length).to eq(0)
      end
    end

    describe "show" do
      routes { FrontEndBuilds::Engine.routes }

      let(:build) { FactoryGirl.create :front_end_builds_build }

      it "should load the app" do
        get :show, id: build.id, format: :json
        expect(response).to be_success
        expect(json['build']['id']).to eq(build.id)
      end
    end

    describe "create" do
      before(:each) do
        oldbuild = FactoryGirl.create :front_end_builds_build,
          app: app,
          endpoint: 'http://www.ted.com/testing/build',
          created_at: 1.day.ago,
          fetched: true,
          html: 'the old build'

        app.live_build = oldbuild

        stub_request(
          :get,
          'http://www.ted.com/testing/build'
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
          endpoint: 'http://www.ted.com/testing/build'
        }

        expect(app.live_build.html).to eq('fetched html')
      end

      it "should not active a build if the app requires manual activiation" do
        app.update_attributes(require_manual_activation: true)

        post :create, {
          app_name: app.name,
          api_key: app.api_key,
          branch: 'master',
          sha: 'some-sha',
          job: '1',
          endpoint: 'http://www.ted.com/testing/build'
        }

        expect(response).to be_success
        expect(app.live_build.html).to eq('the old build')
      end

      it "should error if the api key does not match" do
        post :create, {
          app_name: app.name,
          api_key: 'a-bad-api-key',
          branch: 'master',
          sha: 'some-sha',
          job: '1',
          endpoint: 'http://www.ted.com/testing/build'
        }

        expect(response).to_not be_success
        expect(response.body).to eq('That app name/API combination was not found.')
      end

      it "should error if not all fields are present" do
        post :create, {
          app_name: app.name,
          api_key: app.api_key
        }
        expect(response).to_not be_success
        expect(response.body).to match("Sha can't be blank")
      end
    end

  end
end
