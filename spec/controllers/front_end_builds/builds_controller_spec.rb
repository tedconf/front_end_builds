require 'rails_helper'

module FrontEndBuilds
  RSpec.describe BuildsController, :type => :controller do
    let(:app) { FactoryGirl.create :front_end_builds_app, name: 'dummy' }

    describe "create" do
      before(:each) do
        FactoryGirl.create :front_end_builds_build,
          app: app,
          endpoint: 'http://www.ted.com/testing/build',
          created_at: 1.day.ago

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

        expect(app.builds.find_best.html).to eq('fetched html')
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
