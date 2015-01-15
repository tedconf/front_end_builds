require 'front_end_builds/routing_constraints/html_routing_constraint'

module ActionDispatch::Routing
  class Mapper

    # Create a front end in your rails router.
    def front_end(name, path = name, options = {})
      defaults = {
          branch: 'master',
          app_name: name
        }.merge(options)

      # Create a new build for this app.
      post(
        "#{path}" => "front_end_builds/builds#create",
        defaults: {
          app_name: name
        }
      )

      # Get the version for this app
      get(
        "#{path}" => "front_end_builds/bests#show",
        defaults: defaults,
        format: :json
      )

      # Get a build for this app.
      constraints FrontEndBuilds::HtmlRoutingConstraint.new do
        get(
          "/#{path}/(*path)" => "front_end_builds/bests#show",
          defaults: defaults
        )

        # Need a better way to do this
        front_end_route = Rails.application.routes.routes.routes.find do |route|
          route.defaults == defaults.merge(
            controller: "front_end_builds/bests",
            action: "show"
          )
        end

        FrontEndBuilds::App.register_url(name, front_end_route.format({}))
      end

    end

  end
end
