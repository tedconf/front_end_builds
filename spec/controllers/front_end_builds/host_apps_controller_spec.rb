require 'rails_helper'

module FrontEndBuilds
  RSpec.describe HostAppsController, :type => :controller do
    routes { FrontEndBuilds::Engine.routes }

    describe 'show' do
      it 'should fetch info about the host application (rails)' do
        get :show, params: { id: 'current' }, format: :json

        expect(response.successful?).to be true
        expect(json['host_app']['id']).to eq('current')
        expect(json['host_app']['name']).to eq('dummy')
      end
    end

  end
end
