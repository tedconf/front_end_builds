require_dependency "front_end_builds/application_controller"

module FrontEndBuilds
  class AppsController < ApplicationController
    before_filter :set_app , :only => [:show, :destroy]
    respond_to :json

    def index
      apps = App.includes(:recent_builds)

      respond_with({
        apps: apps.map(&:serialize),
        builds: apps.map(&:recent_builds)
                  .flat_map(&:to_a)
                  .map(&:serialize)
      })
    end

    def show
      respond_with({
        app: @app.serialize,
        builds: @app.recent_builds.map(&:serialize)
      })
    end

    def create
      @app = FrontEndBuilds::App.new(app_create_params)

      if @app.save!
        respond_with(
          { app: @app },
          location: nil
        )
      else
        respond_with(
          { errors: @app.errors },
          status: :unprocessable_entity
        )
      end
    end

    def destroy
      if @app.destroy
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

    def set_app
      @app = FrontEndBuilds::App.find(params[:id])
    end

    def app_create_params
      params.require(:app).permit(
        :name
      )
    end

  end
end
