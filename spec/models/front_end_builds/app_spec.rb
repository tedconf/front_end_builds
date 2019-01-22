require 'rails_helper'

module FrontEndBuilds
  describe App, :type => :model do
    let(:app) { create(:front_end_builds_app) }

    it { should have_many(:builds) }
    it { should belong_to(:live_build) }
    it { should validate_presence_of(:name) }

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
