require 'action_controller/metal/responder'

module RestfulJSONP
  class JSONPResponder < ActionController::Responder

    def display(resource, given_options = {})
      if format == :json && controller.params[:callback] && !controller.request.xhr?
        # this is a JSONP request (note that JSONP is not done over XHR!)

        jsonp_options = {}
        
        status = given_options[:status] || options[:status]

        if (resource.respond_to?(:errors) && !resource.errors.empty?) ||
            (status && ![:ok, :created].include?(status))
          jsonp_options[:status] = :accepted # we can't return an error HTTP response (e.g. 422 or 500) because it would be ignored :(
          resource = {
            :error => {
              :status => status,
              :data => resource.to_json
            }
          }
        end

        jsonp_options[format] = resource
        jsonp_options[:callback] = controller.params[:callback]

        render options.merge!(given_options).merge!(jsonp_options)
      else
        # this is not a JSONP request; carry on
        super
      end
    end
  end
end
