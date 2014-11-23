require_dependency "front_end_builds/application_controller"

module FrontEndBuilds
  class AdminController < ApplicationController

    def index
      # We need to pass the url which the host app has mounted the
      # engine to into index.html.erb, so the ember app's router
      # will work appropriately.

      # Trim leading/trailing slash marks...
      @baseURL = request.fullpath[1..request.fullpath.length-2]
      render :index, layout: false
    end

  end
end
