require 'rails_helper'

module FrontEndBuilds
  describe App, :type => :model do
    it { should have_many(:builds) }
    it { should have_one(:live_build) }
    it { should validate_presence_of(:name) }

    describe '.register_url / get_url' do
      before(:each) do
        App.register_url('testing', '/testing')
      end

      it 'should set the url hash' do
        expect(App.get_url('testing')).to eq('/testing')
      end
    end

    describe "#ensure_api_key!" do
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

    describe '#get_url' do
      it 'should lookup the url in the Apps url hash' do
        App.register_url('testing', '/testing')
        app = FactoryGirl.create(:front_end_builds_app, name: 'testing')
        expect(app.get_url).to eq('/testing')
      end
    end
  end
end
