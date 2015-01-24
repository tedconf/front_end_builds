require_dependency "front_end_builds/application_controller"

module FrontEndBuilds
  class BuildsController < ApplicationController

    def index
      builds = FrontEndBuilds::Build.where(app_id: params[:app_id])
      respond_with_json({
          builds: builds.map(&:serialize)
        })
    end

    def create
      app = FrontEndBuilds::App
        .where(name: params[:app_name])
        .limit(1)
        .first

      build = app.builds.new(use_params(:build_create_params))

      if build.verify && build.save
        build.fetch!

        if build.automatic_activation? && build.master?
          build.activate!
        end

        head :ok

      else
        build.errors[:base] << 'No access - invalid SSH key' if !build.verify

        render(
          text: 'Could not create the build: ' + build.errors.full_messages.to_s,
          status: :unprocessable_entity
        )
      end
    end

    def show
      build = FrontEndBuilds::Build.find(params[:id])
      respond_with_json({
        build: build.serialize
      })
    end

    private

    def build_create_params_rails_3
      params.slice(
        :branch,
        :sha,
        :job,
        :endpoint,
        :signature
      )
    end

    def build_create_params_rails_4
      params.permit(
        :branch,
        :sha,
        :job,
        :endpoint,
        :signature
      )
    end
  end
end
