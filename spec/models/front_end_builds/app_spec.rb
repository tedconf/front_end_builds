require 'rails_helper'

module FrontEndBuilds
  describe App, :type => :model do
    it { should have_many(:builds) }
    it { should validate_presence_of(:name) }

    describe "ensure_api_key!" do
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

  end
end
