require 'net/http'
require 'uri'

module FrontEndBuilds
  class Build < ActiveRecord::Base
    belongs_to :app, class_name: "FrontEndBuilds::App"

    validates :app, presence: true
    validates :sha, presence: true
    validates :job, presence: true
    validates :branch, presence: true

    def self.find_best(params = {})
      scope = self

      query = {
        fetched: true
      }

      if params[:app]
        query[:app] = params[:app]
      end

      if params[:app_name]
        scope = scope
          .joins(:app)
          .where(
            front_end_builds_apps: { name: params[:app_name] }
          )
      end

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

      scope
        .where(query)
        .limit(1)
        .order('created_at desc')
        .first
    end

    def fetch!
      return if fetched?

      # Store endpoint in app
      endpoint = "http://ted.conferences.#{app.name}.s3-website-us-east-1.amazonaws.com/dist-#{job}-#{sha}/index.html"
      html = Net::HTTP.get(URI.parse(endpoint))

      update_attributes(
        html: html,
        fetched: true
      )
    end

    def activate!
      update_attributes(active: true)
    end

    def with_head_tag(tag)
      html.clone.insert(head_pos, tag)
    end

    private

    def head_pos
      head_open = html.index("<head")
      if head_open
        html.index(">", head_open) + 1
      else
        0
      end
    end
  end
end
