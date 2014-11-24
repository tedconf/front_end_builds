require_dependency "front_end_builds/application_controller"

module FrontEndBuilds
  class AppsController < ApplicationController
    respond_to :json

    def index
      @apps = []
      @builds = []

      FrontEndBuilds::App.all.each do |app|
        # Add this app's builds to @builds
        @builds.push app.builds

        # Add this app's build IDs to app's hash
        build_ids = app.builds.map {|build| build.id}
        app = app.as_json.merge( {build_ids: build_ids} )

        # Add app hash to @apps
        @apps.push app
      end

      respond_with ({
        apps: @apps,
        builds: @builds
      })
    end

    def create
      @app = FrontEndBuilds::App.new(app_create_params)

      if @app.save!
        hash = { app: @app }
        respond_with hash, location: nil

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
