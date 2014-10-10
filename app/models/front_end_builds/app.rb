module FrontEndBuilds
  class App < ActiveRecord::Base
    has_many :builds, class_name: 'FrontEndBuilds::Build'

    validates :name, presence: true
    validates :api_key, presence: true

    before_validation :ensure_api_key!

    def ensure_api_key!
      self.api_key = SecureRandom.uuid if api_key.blank?
    end
  end
end
