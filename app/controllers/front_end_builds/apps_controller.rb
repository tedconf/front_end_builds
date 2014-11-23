require_dependency "front_end_builds/application_controller"

module FrontEndBuilds
  class AppsController < ApplicationController
    respond_to :json

    def index
      respond_with FrontEndBuilds::App.all
    end

    def create
      @app = FrontEndBuilds::App.new(app_create_params)

      if @app.save!
        respond_with @app, location: nil

      else
        respond_with(
          {errors: @app.errors},
          status: :unprocessable_entity
        )
      end
    end

    private

    def app_create_params
      params.require(:app).permit(
        :name
      )
    end
  end
end
