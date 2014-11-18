require_dependency "front_end_builds/application_controller"

module FrontEndBuilds
  class AppsController < ApplicationController
    respond_to :json

    def create
      @app = FrontEndBuilds::App.new(app_create_params)

      if @app.save!
        # render json: @app
        respond_with @app, location: nil
        # respond_with :front_end_builds, @app
        # respond_with :front_end_builds, @app

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
