module FrontEndBuilds
  class App < ActiveRecord::Base
    if defined?(ProtectedAttributes) || ::ActiveRecord::VERSION::MAJOR < 4
      attr_accessible :name,
                      :require_manual_activation,
                      :live_build_id
    end

    belongs_to :live_build, class_name: 'FrontEndBuilds::Build', optional: true
    has_many :builds, class_name: 'FrontEndBuilds::Build'

    if ActiveRecord::VERSION::MAJOR < 4
      # Rails 3
      has_many :recent_builds,
        class_name: "FrontEndBuilds::Build",
        limit: 10,
        order: 'created_at desc'
    else
      # Rails 4
      has_many :recent_builds, -> { recent },
        class_name: "FrontEndBuilds::Build"
    end

    validates :name, presence: true

    validate do |app|
      live_build_validator(app)
    end

    def live_build_validator(app)
      return unless deploy_restrictions?
      return if app.new_record?
      ensure_acceptable_branch(app)
    end

    def ensure_acceptable_branch(app)
      build = FrontEndBuilds::Build.find(app.live_build_id)
      production_branch = ENV["FRONT_END_BUILDS_PRODUCTION_BRANCH"]
      if production_branch != build.branch
        app.errors[:validations] << "Cannot activate build - build is from branch: #{build.branch}, but deploys are restricted to branch: #{production_branch}"
      end
    end

    def deploy_restrictions?
      ENV["FRONT_END_BUILDS_RESTRICT_DEPLOYS"] == "TRUE"
    end

    def self.register_url(name, url)
      @_url ||= {}
      @_url[name.to_sym] = url
    end

    def self.get_url(name)
      @_url ||= {}
      @_url[name.to_sym]
    end

    def get_url
      self.class.get_url(name)
    end

    def serialize
      {
        id: id,
        name: name,
        build_ids: recent_builds.map(&:id),
        live_build_id: (live_build ? live_build.id : nil),
        location: get_url,
        require_manual_activation: require_manual_activation
      }
    end
  end
end
