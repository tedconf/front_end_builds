require_dependency "front_end_builds/application_controller"

module FrontEndBuilds

  # This controller is responsible for serving the index.html
  # based on the incoming params. This is what serves you front
  # end.
  #
  # Best is not a resource, but we are going to isolate serving the
  # best build to its own controller.
  class BestsController < ApplicationController
    before_filter :find_front_end, only: [:show]

    def show
      if @front_end
        respond_to do |format|
          format.html { render text: @front_end.with_head_tag(csrf_tag) }
          format.json { render json: { version: @front_end.id } }
        end
      else
        # TODO install instructions, user needs to push build
        render text: "not found", status: 404
      end
    end


    private

    def csrf_tag
      [
        "<meta name='csrf-param' content='#{request_forgery_protection_token}' />",
        "<meta name='csrf-token' content='#{form_authenticity_token}' />",
        "<meta name='front-end-build-version' content='#{@front_end.id}' />"
      ].join('').to_s
    end

    def find_front_end
      @front_end = FrontEndBuilds::Build.find_best(build_search_params)
    end

    def build_search_params
      params.permit(:app_name, :branch, :sha, :job)
    end
  end
end
