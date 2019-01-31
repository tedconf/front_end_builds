require 'rails_helper'

module FrontEndBuilds
  RSpec.describe PubkeysController, :type => :controller do
    routes { FrontEndBuilds::Engine.routes }

    describe 'index' do
      let!(:keys) { create_list(:front_end_builds_pubkey, 3) }

      it 'should list all pubkeys' do
        get :index, format: :json

        expect(response).to be_success
        expect(json['pubkeys'].size).to eq(3)
      end
    end

    describe 'create' do
      it 'should create a new pubkey' do
        post :create,
          params: {
            pubkey: {
              name: 'my-new-key',
              pubkey: 'asdfasdf'
            }
          },
          format: :json

        expect(response).to be_success

        key = FrontEndBuilds::Pubkey
          .where(name: 'my-new-key')
          .limit(1)
          .first

        expect(key.pubkey).to eq('asdfasdf')
      end

      it 'should not create a new pubkey without a pubkey' do
        post :create,
          params: {
            pubkey: {
              name: 'my-new-key'
            }
          },
          format: :json

        expect(response).to_not be_success
        expect(json['errors']['pubkey'].size).to eq(1)
      end
    end

    describe 'destroy' do
      let(:pubkey) { create(:front_end_builds_pubkey) }

      it 'should remove a pubkey' do
        delete :destroy, params: { id: pubkey.id }, format: :json

        expect(response).to be_success

        lookup_pubkey = FrontEndBuilds::Pubkey
          .where(id: pubkey.id)
          .limit(1)
          .first

        expect(lookup_pubkey).to be_nil
      end
    end
  end
end
