Gem::Specification.new do |gem|
  gem.name     = "restful_jsonp"
  gem.version  = "1.0.0"
  gem.authors  = ["Matt Zukowski"]
  gem.email    = ["matt.zukowski@utoronto.ca"]
  gem.homepage = "http://github.com/educoder/restful_jsonp"
  gem.summary  = "Makes your RESTful Rails service accessible using JSONP. Use the '_method' parameter in your requests to specify the request method."
  gem.description = "Normally Rails/Rack only checks the '_method' parameter in POST requests, but JSONP requests are always GETs. This railtie enables the '_method' check for all request types, including GET."
  gem.require_paths = ["lib"]

  gem.files = `git ls-files`.split("\n")

  gem.add_dependency "rack", "~> 1"
  gem.add_dependency "rails", "~> 3"
end
