require_dependency "front_end_builds/application_controller"

module FrontEndBuilds
  class PubkeysController < ApplicationController
    def index
      keys = FrontEndBuilds::Pubkey.order(:name)
      respond_with_json(pubkeys: keys.map(&:serialize))
    end

    def create
      pubkey = FrontEndBuilds::Pubkey.new(pubkey_create_params)

      if pubkey.save
        respond_with_json(
          { pubkey: pubkey.serialize },
          location: nil
        )
      else
        error!(pubkey.errors)
      end
    end

    def destroy
      pubkey = FrontEndBuilds::Pubkey.find(params[:id])

      if pubkey.destroy
        respond_with_json(
          { pubkey: { id: pubkey.id } },
          location: nil
        )
      else
        error!(pubkey.errors)
      end
    end

    private

    def pubkey_create_params
      params.require(:pubkey).permit(
        :name,
        :pubkey
      )
    end
  end
end
