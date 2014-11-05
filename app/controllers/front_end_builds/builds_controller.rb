require_dependency "front_end_builds/application_controller"

module FrontEndBuilds
  class BuildsController < ApplicationController
    before_filter :set_app!, only: :create

    def index
      front_end = FrontEndBuilds::Build.find_best(build_search_params)

      if front_end
        render text: front_end.with_head_tag(csrf_tag)
      else
        render text: "not found", status: 404
      end
    end

    def create
      build = @app.builds.new(build_create_params)

      if build.save
        build.fetch!
        build.activate!
        head :ok

      else
        render(
          text: 'Could not create the build: ' + build.errors.full_messages.to_s,
          status: :unprocessable_entity
        )
      end
    end

    private

    def set_app!
      @app = find_app
      if @app.nil?
        render(
          text: 'That app name/API combination was not found.',
          status: :unprocessable_entity
        )
      end
    end

    def csrf_tag
      [
        "<meta name='csrf-param' content='#{request_forgery_protection_token}' />",
        "<meta name='csrf-token' content='#{form_authenticity_token}' />"
      ].join('').to_s
    end

    def build_search_params
      params.permit(:app_name, :branch, :sha, :job)
    end

    def build_create_params
      params.permit(
        :branch,
        :sha,
        :job
      )
    end

    def find_app
      FrontEndBuilds::App.where(
        name: params[:app_name],
        api_key: params[:api_key]
      ).limit(1).first
    end
  end
end
