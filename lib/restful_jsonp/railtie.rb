require 'rails'
require 'restful_jsonp_railtie' # the gem
require 'restful_jsonp/middleware'

module RestfulJSONP
  class Railtie < Rail::Railtie
    railtie_name :restful_jsonp

    initializer "restful_jsonp.replace_rack_methodoverride" do |app|
      Rails.logger.debug "Swapping in RestfulJSONP Middleware"
      app.app_middleware.swap Rack::MethodOverride, RestfulJSONP::Middleware
    end
  end
end
