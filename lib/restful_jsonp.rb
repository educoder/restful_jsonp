require 'rails'
require 'action_controller/base'

module RestfulJSONP
  class Railtie < Rails::Railtie
    initializer "restful_jsonp.replace_rack_methodoverride" do |app|
      Rails.logger.debug "Swapping in RestfulJSONP Middleware"
      app.middleware.swap Rack::MethodOverride, RestfulJSONP::MethodOverride

      app.action_controller.responder = RestfulJSONP::JSONPResponder
    end

    action_controller "restful_jsonp.use_jsonp_responder" do |app|
      ApplicationController.responder = RestfulJSONP::JSONPResponder
    end
  end
end
