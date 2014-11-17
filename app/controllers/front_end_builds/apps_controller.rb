require_dependency "front_end_builds/application_controller"

module FrontEndBuilds
  class AppsController < ApplicationController
    respond_to :json

    def create
      @app = FrontEndBuilds::App.new(app_create_params)

      if @app.save!
        respond_with @app

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
