require 'rails'
require 'restful_jsonp/method_override'

module RestfulJSONP
  class Railtie < Rails::Railtie
    initializer "restful_jsonp.replace_rack_methodoverride" do |app|
      Rails.logger.debug "Swapping in RestfulJSONP Middleware"
      app.middleware.swap Rack::MethodOverride, RestfulJSONP::MethodOverride
    end
  end
end
