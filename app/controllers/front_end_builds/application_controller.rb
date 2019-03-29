module FrontEndBuilds
  class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token

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
  end
end
