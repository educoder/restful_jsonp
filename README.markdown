RESTful JSONP
============

This is a Rails plugin (Railtie) that allows your existing RESTful controllers to work over JSONP.

##### POST/PUT/DELETE

REST is designed around the four HTTP request methods (`GET`, `POST`, `PUT`, and `DELETE`), but
JSONP requests are always `GET`s. To get around this restriction, this Railtie lets you specify the
desired method in a special `_method` parameter.

For example, to make a `PUT` request to `/users/1.json`, you would make a JSONP (`GET`) request to
`/users/1.json?_method=PUT`.

##### Responder

The plugin also adds a custom Responder for JSONP that automatically adds special behaviour to
`respond_with` (via a custom `display` method). 

For JSONP requests handled with `respond_with`:

1. `:callback => param[:callback]` will be automatically added to the `render` options
2. Error `:status` codes (e.g. `:unprocessable_entity`) will be changed to `:accepted`, 
since error responses cannot be handled by JSONP. To detect errors in JSONP responses
check for an `error` attribute in the returned data.


Installation
---------------

First, install the gem: 

`gem install restful_jsonp`

Then add this to your Rails app's `Gemfile`:

`gem 'restful_jsonp'

Note that this only works for Rails 3. In principle you could try to swap in the RestfulJSONP::MethodOverride
middleware into a Rails 2.3+ app, but this has not been tested.

To enable the custom JSONP Responder, add this to your `ApplicationController` (or any
controller that you want to enable the responder for):

`self.responder = RestfulJSONP::JSONPResponder`


How it Works
------------

The `_method` functionality is built in to Rails (via Rack), but is normally only available for
`POST` requests. This Railtie replaces the default `Rack::MethodOverride` middleware with a slightly
altered version that checks for the `_method` parameter regardless of whether it's in a `POST`
or `GET` request.

Note that this functionality is enabled for all requests, regardless of whether they are done
via JSONP or otherwise.


History
---------

##### 1.0.2

* Fixed error response processing in JSONPResponder 

##### 1.0.0

* Initial release
