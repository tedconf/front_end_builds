require 'front_end_builds/middleware/admin_assets'

module FrontEndBuilds
  class Engine < ::Rails::Engine
    isolate_namespace FrontEndBuilds

    config.generators do |g|
      g.test_framework :rspec, fixture: false
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
      g.assets false
      g.helper false
    end

    initializer "static assets" do |app|
      app.middleware.use(FrontEndBuilds::Middleware::AdminAssets, "#{root}/public")
    end
  end
end
