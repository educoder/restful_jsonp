require 'rails'
require 'action_controller/base'
require 'restful_jsonp/method_override'
require 'restful_jsonp/jsonp_responder'

module RestfulJSONP
  class Railtie < Rails::Railtie
    initializer "restful_jsonp.replace_rack_methodoverride" do |app|
      Rails.logger.debug "Swapping in RestfulJSONP Middleware"
      app.middleware.swap Rack::MethodOverride, RestfulJSONP::MethodOverride
    end
  end
end
