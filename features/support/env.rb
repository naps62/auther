require 'rails'
Bundler.require :default, :development
$:.push(File.expand_path('../../../lib', __FILE__))
require 'auther'

#World(Capybara::RSpecMatchers)
#World(Capybara::DSL)

module RouteProxy
  def method_missing(sym, *args)
    if route_helpers.respond_to?(sym)
      route_helpers.send(sym, *args)
    else
      super
    end
  end

  def route_helpers
    Auther::Engine.routes.url_helpers
  end
end

World(RouteProxy)

Before do
  Auther::Engine.routes.default_url_options[:host] = 'test.host'
end
