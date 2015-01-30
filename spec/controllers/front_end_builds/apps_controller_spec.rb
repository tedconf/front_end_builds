require 'rails_helper'

module FrontEndBuilds
  RSpec.describe AppsController, :type => :controller do
    routes { FrontEndBuilds::Engine.routes }

    let(:app) { FactoryGirl.create :front_end_builds_app, name: 'dummy' }
    let!(:builds) { FactoryGirl.create_list :front_end_builds_build, 2, app: app }
    let!(:live_build) { FactoryGirl.create :front_end_builds_build, :live, :fetched, app: app }

    describe 'index' do
      it "should find all apps" do
        get :index, format: :json

        expect(response).to be_success
        expect(json['apps'].length).to eq(1)
        expect(json['builds'].length).to eq(3)
      end
    end

    describe 'show' do
      it "should find the requested app" do
        get :show, id: app.id, format: :json

        expect(response).to be_success
        expect(json['app']['id']).to eq(app.id)
        expect(json['builds'].length).to eq(3)
        expect(json['app']['live_build_id']).to eq(app.live_build.id)
      end
    end

    describe 'create' do
      it "should create a new app" do
        post :create, app: {
            name: 'my-new-app',
            api_key: nil
          },
          format: :json

        expect(response).to be_success

        # app = FrontEndBuilds::App.find_by(name: 'my-new-app')
        app = FrontEndBuilds::App.where(name: 'my-new-app').limit(1).first
        expect(app.api_key).to be_truthy
        expect(json['app']['id']).to eq(app.id)
      end
    end

    describe 'update' do
      let(:app) { FactoryGirl.create :front_end_builds_app, name: 'forsaken' }
      let!(:live_build) { FactoryGirl.create :front_end_builds_build, :live, :fetched, app: app }
      let!(:new_build) { FactoryGirl.create :front_end_builds_build, :fetched, app: app }

      it "should edit an existing app" do
        post :edit,
          id: app.id,
          app: {
            live_build_id: new_build.id
          },
          format: :json

        expect(response).to be_success

        app.reload

        expect(app.live_build).to eq(new_build)
        expect(json['app']['id']).to eq(app.id)
      end
    end

    describe 'destroy' do
      let(:deletable_app) { FactoryGirl.create :front_end_builds_app, name: 'forsaken' }

      context 'a valid app' do
        before(:each) do
          post :destroy,
            id: deletable_app.id,
            format: :json
        end

        context 'the response' do
          subject { response }
          it { should be_success }
        end

        context 'the data' do
          subject { json['app']['id'] }
          it { should_not be_nil }
        end

        context 'the record' do
          subject { FrontEndBuilds::App.where(id: deletable_app.id).first }
          it { should be_nil }
        end
      end
    end
  end
end
