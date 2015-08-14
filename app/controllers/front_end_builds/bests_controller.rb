require_dependency "front_end_builds/application_controller"

module FrontEndBuilds

  # This controller is responsible for serving the index.html
  # based on the incoming params. This is what serves you front
  # end.
  #
  # Best is not a resource, but we are going to isolate serving the
  # best build to its own controller.
  class BestsController < ApplicationController
    include Rails.application.routes.url_helpers

    before_filter :find_front_end, only: [:show]

    def show
      if @front_end
        respond_to do |format|
          format.html { render text: @front_end.with_head_tag(meta_tags) }
          format.json { render json: { version: @front_end.id } }
        end
      else
        # TODO install instructions, user needs to push build
        render text: "not found", status: 404
      end
    end


    private

    def meta_tags
      tags = {
        csrf_param: request_forgery_protection_token,
        csrf_token: form_authenticity_token,
        front_end_build_version: @front_end.id,
        front_end_build_params: use_params(:build_search_params).to_query,
        front_end_build_url: front_end_builds_best_path(
            use_params(:build_search_params).merge(format: :json)
          )
      }

      tags
        .map { |name, content|
          "<meta name='#{name.to_s.dasherize}' content='#{content}' />"
        }
        .join("\n")
        .to_s
    end

    def find_front_end
      @front_end = FrontEndBuilds::Build.find_best(use_params(:build_search_params).merge({mobile: is_mobile_client?}))
    end

    def build_search_params_rails_3
      params.slice(:app_name, :id, :branch, :sha, :job)
    end

    def build_search_params_rails_4
      params.permit(:app_name, :id, :branch, :sha, :job)
    end
  
    # Use https://github.com/jistr/mobvious
    def is_mobile_client?
      request.env['mobvious.device_type']  == :mobile
    end
  end
end
