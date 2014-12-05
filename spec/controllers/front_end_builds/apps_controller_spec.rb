require 'rails_helper'

module FrontEndBuilds
  RSpec.describe AppsController, :type => :controller do
    routes { FrontEndBuilds::Engine.routes }

    let(:app) { FactoryGirl.create :front_end_builds_app, name: 'dummy' }
    let!(:builds) { FactoryGirl.create_list :front_end_builds_build, 2, app: app }
    let!(:build) { FactoryGirl.create :front_end_builds_build, :fetched, app: app }

    describe 'index' do
      it "should find all apps" do
        get :index, format: :json

        best_build = app.find_best_build
        json_best_builds = json['builds'].select { |x| x['is_best'] }

        expect(response).to be_success
        expect(json['apps'].length).to eq(1)
        expect(json['builds'].length).to eq(3)
        expect(json_best_builds.length).to eq(1)
        expect(json_best_builds[0]['id']).to eq(best_build.id)
      end
    end

    describe 'show' do
      it "should find the requested app" do
        get :show, id: app.id, format: :json

        best_build = app.find_best_build
        json_best_builds = json['builds'].select { |x| x['is_best'] }

        expect(response).to be_success
        expect(json['app']['id']).to eq(app.id)
        expect(json['builds'].length).to eq(3)
        expect(json_best_builds.length).to eq(1)
        expect(json_best_builds[0]['id']).to eq(best_build.id)
      end
    end

    describe 'create' do
      it "should create a new app" do
        post :create, app: {
            name: 'my-new-app',
          },
          format: :json

        expect(response).to be_success

        app = FrontEndBuilds::App.find_by(name: 'my-new-app')
        expect(app.api_key).to be_truthy
        expect(json['app']['id']).to eq(app.id)
      end
    end
  end
end
