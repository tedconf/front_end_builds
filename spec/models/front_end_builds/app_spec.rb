require 'rails_helper'

module FrontEndBuilds
  describe App, :type => :model do
    let(:app) { create(:front_end_builds_app) }

    it { should have_many(:builds) }
    it { should belong_to(:live_build) }
    it { should validate_presence_of(:name) }

    describe '#recent_builds' do
      it 'should only show the 10 most recent builds' do
        create_list(:front_end_builds_build, 11, {
          app: app
        })

        expect(app.recent_builds.size).to eq(10)
      end

      it 'should order the builds with the most recent at top' do
        older = create(:front_end_builds_build, {
          app: app,
          created_at: 2.days.ago
        })

        recent = create(:front_end_builds_build, {
          app: app,
          created_at: 1.day.ago
        })

        expect(app.recent_builds.size).to eq(2)
        expect(app.recent_builds.first).to eq(recent)
        expect(app.recent_builds.second).to eq(older)
      end
    end

    describe '.register_url / get_url' do
      before(:each) do
        App.register_url('testing', '/testing')
      end

      it 'should set the url hash' do
        expect(App.get_url('testing')).to eq('/testing')
      end
    end

    describe '#get_url' do
      it 'should lookup the url in the Apps url hash' do
        App.register_url('testing', '/testing')
        app = create(:front_end_builds_app, name: 'testing')
        expect(app.get_url).to eq('/testing')
      end
    end
  end
end
