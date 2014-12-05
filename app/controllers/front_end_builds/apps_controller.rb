require_dependency "front_end_builds/application_controller"

module FrontEndBuilds
  class AppsController < ApplicationController
    respond_to :json

    def index
      apps = []
      builds = []

      FrontEndBuilds::App.all.each do |app|
        apps.push serialize_app(app)
        builds.concat serialize_builds(app)
      end

      respond_with({
        apps: apps,
        builds: builds
      })
    end

    def show
      @app = FrontEndBuilds::App.find params[:id]

      respond_with({
        app: serialize_app(@app),
        builds: serialize_builds(@app)
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

    def serialize_app(app)
      build_ids = app.builds.map {|build| build.id}

      app.as_json.merge( {build_ids: build_ids} )
    end

    def serialize_builds(app)
      builds = app.builds.as_json
      best_build = app.find_best_build

      if best_build
        builds.each do |build|
          if build["id"] === best_build.id
            build["is_best"] = true
          end
        end
      end

      return builds
    end
  end
end
