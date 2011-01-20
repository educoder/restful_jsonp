require 'rack'

module RestfulJSONP
  class MethodOverride < Rack::MethodOverride
    def call(env)
      req = Rack::Request.new(env)
      method = req.params[METHOD_OVERRIDE_PARAM_KEY] ||
        env[HTTP_METHOD_OVERRIDE_HEADER]
      method = method.to_s.upcase
      if HTTP_METHODS.include?(method)
        env["rack.methodoverride.original_method"] = env["REQUEST_METHOD"]
        env["REQUEST_METHOD"] = method
      end
 
      @app.call(env)
    end
  end
end
