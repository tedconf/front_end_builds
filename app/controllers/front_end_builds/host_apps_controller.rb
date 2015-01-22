require_dependency "front_end_builds/application_controller"

module FrontEndBuilds
  class HostAppsController < ApplicationController
    def show
      respond_with_json({
        host_app: {
          id: params[:id],
          name: Rails.application.class.parent_name
        }
      })
    end
  end
end
