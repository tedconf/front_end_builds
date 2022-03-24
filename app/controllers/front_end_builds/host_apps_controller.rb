require_dependency "front_end_builds/application_controller"

module FrontEndBuilds
  class HostAppsController < ApplicationController
    def show
      respond_with_json({
        host_app: {
          id: params[:id],
          name: Rails.application.class.module_parent_name.underscore
        }
      })
    end
  end
end
