module FrontEndBuilds
  class App < ActiveRecord::Base
    if defined?(ProtectedAttributes) || ::ActiveRecord::VERSION::MAJOR < 4
      attr_accessible :name
    end

    has_many :builds, class_name: 'FrontEndBuilds::Build'

    if ActiveRecord::VERSION::MAJOR < 4
      # Rails 3
      has_many :recent_builds,
        class_name: "FrontEndBuilds::Build",
        limit: 10,
        order: 'created_at'
    else
      # Rails 4
      has_many :recent_builds, -> { recent },
        class_name: "FrontEndBuilds::Build"
    end

    validates :name, presence: true
    validates :api_key, presence: true

    before_validation :ensure_api_key!

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

    def ensure_api_key!
      self.api_key = SecureRandom.uuid if api_key.blank?
    end

    def find_best_build
      builds.find_best
    end

    def serialize
      best = find_best_build

      {
        id: id,
        name: name,
        api_key: api_key,
        build_ids: recent_builds.map(&:id),
        best_build_id: (best ? best.id : nil),
        location: get_url,
        require_manual_activation: require_manual_activation
      }
    end
  end
end
