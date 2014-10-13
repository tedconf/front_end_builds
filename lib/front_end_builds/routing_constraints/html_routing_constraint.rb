module FrontEndBuilds
  class HtmlRoutingConstraint
    def matches?(request)
      request.format == :html && !request.xhr?
    end
  end
end
