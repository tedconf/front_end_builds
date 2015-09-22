module FrontEndBuilds
  class ApplicationController < ActionController::Base

    def use_params(param_method)
      v = Rails::VERSION::MAJOR
      send("#{param_method}_rails_#{v}")
    end

    # Public: A quick helper to create a respond_to block for
    # returning json to the client. Used because `respond_with`
    # is no longer included in Rails.
    def respond_with_json(object, options = {})
      respond_to do |format|
        format.json do
          render options.merge(json: object)
        end
      end
    end

    def error!(errors, status = :unprocessable_entity)
      respond_with_json({ errors: errors }, status: status)
    end

    # Override this method using a decorator to customize what meta tags are 
    # injected into index.html. Most uses cases will probably want to copy
    # these default values into their method and add to them rather than
    # just replace them.
    def feb_meta(app)
      {
        csrf_param: request_forgery_protection_token,
        csrf_token: form_authenticity_token,
        front_end_build_version: app.id,
        front_end_build_params: use_params(:build_search_params).to_query,
        front_end_build_url: front_end_builds_best_path(
            use_params(:build_search_params).merge(format: :json)
          )
      }
    end

  end
end
