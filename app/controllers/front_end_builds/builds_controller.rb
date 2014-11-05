require_dependency "front_end_builds/application_controller"

module FrontEndBuilds
  class BuildsController < ApplicationController

    def index
      front_end = FrontEndBuilds::Build.find_best(build_search_params)

      if front_end
        render text: front_end.with_head_tag(csrf_tag)
      else
        render text: "not found", status: 404
      end
    end

    def create
      app = find_app

      if !app
        render(
          text: 'That app name/api combination was not found.',
          status: :unprocessable_entity
        )

      elsif app
        build = app.builds.new(build_create_params)

        if !build.save
          render(
            text: 'Could not create the build: ' + build.errors.full_messages.to_s,
            status: :unprocessable_entity
          )

        else
          build.fetch!
          build.activate!
          head :ok
        end

      else
        head :unprocessable_entity
      end
    end

    private

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
