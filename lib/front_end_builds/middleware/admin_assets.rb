require 'rack/utils'
require 'active_support/core_ext/uri'
require 'action_dispatch/middleware/static'

module FrontEndBuilds
  module Middleware

    class AdminAssets < ::ActionDispatch::Static
      def front_end_build_asset_regex
        @_regex ||= /^\/front_end_builds\/assets\//
      end

      def requesting_feb_assets?(path)
        path.match(front_end_build_asset_regex)
      end

      def call(env)
        path = env['PATH_INFO']

        # Only call Static middleware if we know this is a request for
        # a front end build asset.
        if requesting_feb_assets?(path)
          super
        else
          @app.call(env)
        end
      end

    end
  end
end
