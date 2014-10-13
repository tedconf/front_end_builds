module FrontEndBuilds
  class HtmlRoutingConstraint
    def matches?(request)
      (request.format == :html || request.format == "*/*") && !request.xhr?
    end
  end
end
