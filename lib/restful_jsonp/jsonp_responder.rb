require 'action_controller/responder'

module RestfulJSONP
  class JSONPResponder < ActionController::Responder
    def display(resource, given_options = {})
debugger
      if params[:format].intern == 'json' && params[:callback] && !request.xhr? # JSONP requests are NOT xhr
        jsonp_options = {
          params[:format].intern => resource,
          :callback => params[:callback]
        }
	
        if (resource.respond_to?(:errors) && !resource.errors.empty?) ||
            (given_options[:status] && ![:ok, :created].include?(given_options[:status]))
          jsonp_options[:status] = :accepted # we can't return an error HTTP response (e.g. 422 or 500) because it would be ignored :(
          resource = {
            :error => {
              :status => given_options[:status],
              :data => resource.to_json
            }
          }
        end

        render given_options.merge!(jsonp_options)
      else
        super
      end
    end
  end
end
