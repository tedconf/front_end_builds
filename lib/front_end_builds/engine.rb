module FrontEndBuilds
  class Engine < ::Rails::Engine
    isolate_namespace FrontEndBuilds

    config.generators do |g|
      g.test_framework :rspec, fixture: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.assets false
      g.helper false
    end

     # Initializer to combine this engines static assets with the static assets of the hosting site.
    initializer "static assets" do |app|
      app.middleware.insert_before(::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public")
    end
  end
end
