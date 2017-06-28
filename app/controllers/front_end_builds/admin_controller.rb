require_dependency "front_end_builds/application_controller"

module FrontEndBuilds
  class AdminController < ApplicationController

    def index
      # We need to pass the url which the host app has mounted the
      # engine to into index.html.erb, so the ember app's router
      # will work appropriately.

      # Trim trailing slash marks
      baseURL = admin_path[1..-2]

      html = render_to_string
      html = html.sub('BASEURL/', baseURL)
      html = html.sub("baseURL: ''", "baseURL: '#{baseURL}'")

      render plain: html
    end

  end
end
