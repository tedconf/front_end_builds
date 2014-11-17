require_dependency "front_end_builds/application_controller"

module FrontEndBuilds
  class AdminController < ApplicationController

    def index
      render :index, layout: false
    end

  end
end
