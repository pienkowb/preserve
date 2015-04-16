# Preserve

Preserve is a Rails plugin which stores selected parameters in a session to make them available in subsequent requests.

## Installation

Add the following line to your application's Gemfile:

```ruby
gem 'preserve'
```

Install the gem with Bundler:

```
$ bundle install
```

Or do it manually by running:

```
$ gem install preserve
```

## Usage

For the sole purpose of this example, assume we have a Rails application with a controller showing all parameters sent in a request.

```ruby
class ParametersController < ApplicationController
  def index
    render json: request_parameters
  end

  private

  def request_parameters
    params.except :controller, :action
  end
end
```

Routes are declared as following:

```ruby
Demo::Application.routes.draw do
  resources :parameters, only: :index
end
```

Let's start the application and test its behaviour using [cURL](http://curl.haxx.se/).
The whole concept is based on a session, so in order for this to work, the cookie engine must be enabled (hence `-c` and `-b` options).

In the first request, the `per_page` parameter is set to 20.

```
$ curl -c cookies http://localhost:3000/parameters?per_page=20
```
```json
{"per_page":"20"}
```

As expected, the application returns the parameter and its value.

The next request is sent without any parameters.

```
$ curl -b cookies http://localhost:3000/parameters
```
```json
{}
```

Obviously, the `per_page` parameter is no longer available.

Now, let's call the `preserve` method inside the `ParametersController` class with the parameter name as an argument.

```ruby
class ParametersController < ApplicationController
  preserve :per_page

  # ...
end
```

Sending the same two requests again gives a different result.

```
$ curl -c cookies http://localhost:3000/parameters?per_page=20
```
```json
{"per_page":"20"}
```

```
$ curl -b cookies http://localhost:3000/parameters
```
```json
{"per_page":"20"}
```

This time, the `per_page` parameter is still available when the second request is made, even though it wasn't sent particularly in that request.

### Multiple parameters

If more than one parameter needs to be preserved within the same controller, its name can be passed as a succeeding argument to the `preserve` method.

```ruby
preserve :per_page, :page
```
