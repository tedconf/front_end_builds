require 'open-uri'

module FrontEndBuilds
  class Build < ActiveRecord::Base
    if defined?(ProtectedAttributes) || ::ActiveRecord::VERSION::MAJOR < 4
      attr_accessible :branch,
                      :sha,
                      :endpoint,
                      :signature
    end

    belongs_to :app, class_name: "FrontEndBuilds::App"
    belongs_to :pubkey, class_name: "FrontEndBuilds::Pubkey"

    validates :app, presence: true
    validates :sha, presence: true
    validates :branch, presence: true
    validates :endpoint, presence: true
    validates :signature, presence: true

    scope :recent, -> { limit(10).order('created_at desc') }

    def self.find_best(params = {})
      scope = self

      query = {
        fetched: true
      }

      if params[:app]
        query[:app_id] = params[:app].id
        app = App.find( params[:app].id )
      end

      if params[:app_name]
        scope = scope
          .joins(:app)
          .where(
            front_end_builds_apps: { name: params[:app_name] }
          )
        condition = {name: params[:name]}
        condition.merge!({client: 'mobile'}) if params[:mobile]
        app = App.where(condition).first
      end

      if params[:id]
        query[:id] = params[:id]

      elsif params[:sha]
        query[:sha] = params[:sha]

      elsif params[:job]
        query[:job] = params[:job]

      elsif params[:branch]
        query[:branch] = params[:branch]

      elsif app
        query[:id] = app.live_build_id

      end

      scope
        .where(query)
        .limit(1)
        .order('created_at desc')
        .first
    end

    # Public: Is the signature is valid for the build.
    #
    # Returns boolean.
    def verify
      !!matching_pubkey
    end

    # Public: Find the pubkey that can verify the builds
    # signature.
    def matching_pubkey
      Pubkey.all
        .detect { |key| key.verify(self) }
        .tap { |key| self.pubkey = key }
    end

    def setup!
      fetch!

      if automatic_activation? && master?
        activate!
      end
    end

    def live?
      self == app.live_build
    end

    def master?
      branch == 'master'
    end

    def fetch!
      return if fetched?

      html = URI.parse(endpoint).read

      self.html = html
      self.fetched = true
      save
    end

    def activate!
      app.live_build = self
      app.save
    end

    def automatic_activation?
      !app.require_manual_activation?
    end

    def with_head_tag(tag)
      html.clone.insert(head_pos, tag)
    end

    def serialize
      {
        id: id,
        app_id: app_id,
        sha: sha,
        branch: branch,
        job: job,
        created_at: created_at
      }
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
