module FrontEndBuilds
  class ApplicationController < ActionController::Base

    def use_params(param_method)
      v = Rails::VERSION::MAJOR
      send("#{param_method}_rails_#{v}")
    end

  end
end
