require 'rails_helper'

module FrontEndBuilds
  RSpec.describe AppsController, :type => :controller do
    routes { FrontEndBuilds::Engine.routes }

    let(:app) { create(:front_end_builds_app, name: 'dummy') }
    let!(:builds) { create_list(:front_end_builds_build, 2, app: app) }
    let!(:live_build) { create(:front_end_builds_build, :live, :fetched, app: app) }

    describe 'index' do
      it "should find all apps" do
        get :index, format: :json

        expect(response).to be_success
        expect(json['apps'].length).to eq(1)
        expect(json['builds'].length).to eq(3)
      end

      # This specs query composition b/c it changed slightly between rails 4 and rails 5
      # in regards to includes
      describe "testing query composition", focus: true do
        # getting rid of the ones from the outer describe
        before(:each) do
          App.delete_all
          Build.delete_all
        end

        let(:app1) { create(:front_end_builds_app, name: 'dummy') }
        let(:app2) { create(:front_end_builds_app, name: 'dummy2') }
        let!(:app1_builds) { create_list(:front_end_builds_build, 1, app: app1) }
        let!(:app2_builds) { create_list(:front_end_builds_build, 10, app: app2) }

        it "Finds the correct builds_ids for EACH app" do
          get :index, format: :json

          expect(response).to be_success
          expect(json['apps'].length).to eq(2)
          app1_json = json['apps'].select{|x| x['id'] == app1.id}.first
          app2_json = json['apps'].select{|x| x['id'] == app2.id}.first

          # make sure the oldest app (by created_by) shows up
          # this rows ends up missing if include(:recent_builds) is in the Arel
          expect(app1_json['build_ids']).to match(app1_builds.map(&:id))

          expect(app2_json['build_ids']).to match( app2.recent_builds.map(&:id))
        end
      end
    end

    describe 'show' do
      it "should find the requested app" do
        get :show, params: { id: app.id }, format: :json

        expect(response).to be_success
        expect(json['app']['id']).to eq(app.id)
        expect(json['builds'].length).to eq(3)
        expect(json['app']['live_build_id']).to eq(app.live_build.id)
      end
    end

    describe 'create' do
      it "should create a new app" do
        post :create, params: {
            app: {
              name: 'my-new-app'
            }
          },
          format: :json

        expect(response).to be_success

        app = FrontEndBuilds::App.where(name: 'my-new-app').limit(1).first
        expect(json['app']['id']).to eq(app.id)
      end
    end

    describe 'update' do
      let(:app) { create :front_end_builds_app, name: 'forsaken' }
      let!(:live_build) { create :front_end_builds_build, :live, :fetched, app: app }
      let!(:new_build) { create :front_end_builds_build, :fetched, app: app }

      it "should edit an existing app" do
        post :update,
          params: {
            id: app.id,
            app: {
              live_build_id: new_build.id
            }
          },
          format: :json

        expect(response).to be_success

        app.reload

        expect(app.live_build).to eq(new_build)
        expect(json['app']['id']).to eq(app.id)
      end
    end

    describe 'destroy' do
      let(:deletable_app) { create :front_end_builds_app, name: 'forsaken' }

      context 'a valid app' do
        before(:each) do
          post :destroy,
            params: {
              id: deletable_app.id
            },
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
