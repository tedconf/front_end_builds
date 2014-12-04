module FrontEndBuilds
  class App < ActiveRecord::Base
    has_many :builds, class_name: 'FrontEndBuilds::Build'

    validates :name, presence: true
    validates :api_key, presence: true

    before_validation :ensure_api_key!

    def ensure_api_key!
      self.api_key = SecureRandom.uuid if api_key.blank?
    end

    def find_best_build(params = {})
      query = {
        fetched: true
      }

      if params[:sha]
        query[:sha] = params[:sha]

      elsif params[:job]
        query[:job] = params[:job]

      elsif params[:branch]
        # only force activeness on branch based searched. Anyone who
        # is searching by sha or build# is probably debugging/testing,
        # so they would want non active builds
        query[:branch] = params[:branch]
        query[:active] = true

      end

      builds
        .where(query)
        .limit(1)
        .order('created_at desc')
        .first

    end
  end
end
