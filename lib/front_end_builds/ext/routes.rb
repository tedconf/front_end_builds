require 'front_end_builds/routing_constraints/html_routing_constraint'

module ActionDispatch::Routing
  class Mapper

    # Create a front end in your rails router.
    def front_end(name, path = name, options = {})

      # Generic routes that have nothing to do with the app
      # name. Use this for testing or providing a non
      # app api endpoint.
      namespace :front_end_builds do
        resources :builds, only: [:index, :create]
      end

      # Create a new build for this app.
      post(
        "#{path}" => "front_end_builds/builds#create",
        defaults: {
          app_name: name
        }
      )

      # Get a build for this app.
      constraints FrontEndBuilds::HtmlRoutingConstraint.new do
        get(
          "/#{path}/(*path)" => "front_end_builds/builds#index",
          defaults: {
            branch: 'master',
            app_name: name
          }.merge(options)
        )
      end
    end

  end
end
