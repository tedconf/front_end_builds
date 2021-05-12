module FrontEndBuilds
  class App < ActiveRecord::Base
    if defined?(ProtectedAttributes) || ::ActiveRecord::VERSION::MAJOR < 4
      attr_accessible :name,
                      :require_manual_activation,
                      :live_build_id
    end

    belongs_to :live_build, class_name: 'FrontEndBuilds::Build', optional: true
    has_many :builds, class_name: 'FrontEndBuilds::Build'

    validates :name, presence: true

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
        live_build_id: (live_build ? live_build.id : nil),
        location: get_url,
        require_manual_activation: require_manual_activation
      }
    end
  end
end
