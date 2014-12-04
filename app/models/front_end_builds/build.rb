require 'net/http'
require 'uri'

module FrontEndBuilds
  class Build < ActiveRecord::Base
    belongs_to :app, class_name: "FrontEndBuilds::App"

    validates :app, presence: true
    validates :sha, presence: true
    validates :branch, presence: true
    validates :endpoint, presence: true

    def fetch!
      return if fetched?

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
