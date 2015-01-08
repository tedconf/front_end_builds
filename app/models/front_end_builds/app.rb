module FrontEndBuilds
  class App < ActiveRecord::Base
    if defined?(ProtectedAttributes) || ::ActiveRecord::VERSION::MAJOR < 4
      attr_accessible :name
    end

    has_many :builds, class_name: 'FrontEndBuilds::Build'

    validates :name, presence: true
    validates :api_key, presence: true

    before_validation :ensure_api_key!

    def ensure_api_key!
      self.api_key = SecureRandom.uuid if api_key.blank?
    end

    def find_best_build
      FrontEndBuilds::Build.find_best({
        app: self
      })
    end
  end
end
