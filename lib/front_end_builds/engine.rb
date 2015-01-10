module FrontEndBuilds
  class Engine < ::Rails::Engine
    isolate_namespace FrontEndBuilds

    config.generators do |g|
      g.test_framework :rspec, fixture: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.assets false
      g.helper false
    end

    initializer "front_end_assets.assets.precompile", group: :all do |app|
      app.config.assets.precompile += %w(
        front_end_builds/vendor.css
        front_end_builds/admin.css
        front_end_builds/vendor.js
        front_end_builds/admin.js
      )
    end
  end
end
