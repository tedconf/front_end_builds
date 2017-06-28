require 'rails_helper'

module FrontEndBuilds
  RSpec.describe BuildsController, :type => :controller do
    let(:app) { FactoryGirl.create :front_end_builds_app, name: 'dummy' }

    describe "index" do
      routes { FrontEndBuilds::Engine.routes }

      it "should list all the builds for an app" do
        FactoryGirl.create_list(:front_end_builds_build, 3, app: app)

        get :index, params: { app_id: app.id }, format: :json
        expect(response).to be_success
        expect(json['builds'].length).to eq(3)
      end

      it 'should be scoped to the requested app' do
        build1 = FactoryGirl.create(:front_end_builds_build, app: app)
        FactoryGirl.create(:front_end_builds_build)

        get :index, params: { app_id: app.id }, format: :json
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
        get :show, params: { id: build.id }, format: :json
        expect(response).to be_success
        expect(json['build']['id']).to eq(build.id)
      end
    end

    describe "create" do
      let(:endpoint) { 'http://www.ted.com/testing/build' }

      before(:each) do
        FactoryGirl.create :front_end_builds_build, :live,
          app: app,
          endpoint: 'http://www.ted.com/testing/build',
          created_at: 1.day.ago,
          fetched: true,
          html: 'the old build'

        FactoryGirl.create(:front_end_builds_pubkey, :fixture_pubkey)

        stub_request(:get, endpoint)
          .to_return(body: 'fetched html')
      end

      it "should create the new build, and make it live" do
        expect(app.live_build.html).to eq('the old build')

        post :create, params: {
          app_name: app.name,
          branch: 'master',
          sha: 'some-sha',
          job: '1',
          endpoint: endpoint,
          signature: create_signature("#{app.name}-#{endpoint}")
        }

        expect(response).to be_success
        expect(app.reload.live_build.html).to eq('fetched html')
      end

      it "should not make a new build live if it's non-master" do
        expect(app.live_build.html).to eq('the old build')

        post :create, params: {
          app_name: app.name,
          branch: 'some-feature',
          sha: 'some-sha',
          job: '1',
          endpoint: endpoint,
          signature: create_signature("#{app.name}-#{endpoint}")
        }

        expect(response).to be_success
        expect(app.reload.live_build.html).to eq('the old build')
      end

      it "should not active a build if the app requires manual activiation" do
        app.update_attributes(require_manual_activation: true)

        post :create, params: {
          app_name: app.name,
          branch: 'master',
          sha: 'some-sha',
          job: '1',
          endpoint: endpoint,
          signature: create_signature("#{app.name}-#{endpoint}")
        }

        expect(response).to be_success
        expect(app.live_build.html).to eq('the old build')
      end

      it 'should error if the app cannot be found' do
        app.update_attributes(require_manual_activation: true)

        post :create, params: {
          app_name: 'this-does-not-exist',
          branch: 'master',
          sha: 'some-sha',
          job: '1',
          endpoint: endpoint,
          signature: create_signature("unknown-#{endpoint}")
        }

        expect(response).to_not be_success
        expect(response.body).to eq('No app named this-does-not-exist.')
      end

      it "should error if the signature is not valid" do
        pkey = OpenSSL::PKey::RSA.new(2048)
        digest = OpenSSL::Digest::SHA256.new
        signature = pkey.sign(digest, "#{app.name}-#{endpoint}")

        post :create, params: {
          app_name: app.name,
          branch: 'master',
          sha: 'some-sha',
          job: '1',
          endpoint: endpoint,
          signature: Base64.encode64(signature)
        }

        expect(response).to_not be_success
        expect(response.body).to match("No access - invalid SSH key")
      end

      it "should error if not all fields are present" do
        post :create, params: {
          app_name: app.name,
          endpoint: endpoint,
          signature: create_signature("#{app.name}-#{endpoint}")
        }
        expect(response).to_not be_success
        expect(response.body).to match("Sha can't be blank")
      end

      it 'should let the html be submitted' do
        post :create, params: {
          app_name: app.name,
          branch: 'master',
          sha: 'some-sha',
          job: '1',
          html: 'hello world',
          signature: create_signature('hello world')
        }

        expect(response).to be_success
        expect(app.live_build.html).to eq('the old build')
      end
    end

  end
end
