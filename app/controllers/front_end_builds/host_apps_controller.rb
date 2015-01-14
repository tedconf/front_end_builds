require_dependency "front_end_builds/application_controller"

module FrontEndBuilds
  class HostAppsController < ApplicationController
    respond_to :json

    def show
      respond_with({
        host_app: {
          id: params[:id],
          name: Rails.application.class.parent_name
        }
      })
    end
  end
end
