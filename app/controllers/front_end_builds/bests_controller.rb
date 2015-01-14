require_dependency "front_end_builds/application_controller"

module FrontEndBuilds

  # This controller is responsible for serving the index.html
  # based on the incoming params. This is what serves you front
  # end.
  #
  # Best is not a resource, but we are going to isolate serving the
  # best build to its own controller.
  class BestsController < ApplicationController

    def show
      front_end = FrontEndBuilds::Build.find_best(build_search_params)

      if front_end
        render text: front_end.with_head_tag(csrf_tag)
      else
        # TODO install instructions, user needs to push build
        render text: "not found", status: 404
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
  end
end
