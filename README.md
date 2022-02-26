# Preserve [![Gem version](https://img.shields.io/gem/v/preserve)](https://rubygems.org/gems/preserve) [![Build status](https://img.shields.io/github/workflow/status/pienkowb/preserve/Test/develop)](https://github.com/pienkowb/preserve/actions/workflows/test.yml?query=branch%3Adevelop) [![Coverage status](https://img.shields.io/coveralls/github/pienkowb/preserve/develop)](https://coveralls.io/github/pienkowb/preserve) [![Maintainability status](https://img.shields.io/codeclimate/maintainability/pienkowb/preserve)](https://codeclimate.com/github/pienkowb/preserve)

Preserve is a Rails plugin which stores selected parameters in the session to make them available in subsequent requests.

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

For the sole purpose of this example, let's assume we have a Rails application with a controller showing all parameters sent in a request.

```ruby
class ParametersController < ApplicationController
  def index
    render json: parameters
  end

  private

  def parameters
    params.except(:controller, :action)
  end
end
```

Routes are declared as following:

```ruby
Rails.application.routes.draw do
  resources :parameters, only: :index
end
```

Let's start the application and test its behavior using [cURL](https://curl.haxx.se/).
The whole concept is based on the session, so in order for this to work the cookie engine must be enabled (hence the `-c` and `-b` options).

In the first request, the `status` parameter is set to `active`.

```
$ curl -c cookies http://localhost:3000/parameters?status=active
```
```json
{"status":"active"}
```

As expected, the application returns the parameter and its value.

The next request is sent without any parameters.

```
$ curl -b cookies http://localhost:3000/parameters
```
```json
{}
```

Obviously, the `status` parameter is no longer available.

Now, let's call the `preserve` macro inside the `ParametersController` class with the parameter name as an argument.

```ruby
class ParametersController < ApplicationController
  preserve :status

  # ...
end
```

Sending the same two requests again yields a different result.

```
$ curl -c cookies http://localhost:3000/parameters?status=active
```
```json
{"status":"active"}
```

```
$ curl -b cookies http://localhost:3000/parameters
```
```json
{"status":"active"}
```

This time, the `status` parameter is still available when the second request is made, even though it wasn't sent particularly in that request.

### Multiple arguments

If more than one parameter needs to be preserved within the same controller, its name can be passed as a succeeding argument to the `preserve` method.

```ruby
preserve :page, :per_page
```

### Action restrictions

Limiting functionality provided by the gem to a certain set of controller actions can be achieved by applying the `only` (or `except`) option.
For example:

```ruby
preserve :status, only: :index
```

The behavior is exactly the same as with an [Action Controller filter](https://guides.rubyonrails.org/action_controller_overview.html#filters).

### Application-wide parameters

Parameters used across the whole application can be persisted by adding the `preserve` macro to the `ApplicationController`.

```ruby
class ApplicationController < ActionController::Base
  preserve :locale
end
```

In more complex scenarios, controller inheritance can be utilized to further adjust the scope.

### Nested parameters

Storing a value of a nested parameter requires calling the `preserve` macro with an array of consecutive keys leading to that parameter in the parameters hash (similar to the [`Hash#dig`](https://apidock.com/ruby/Hash/dig) method).

For example, in case of the JSON payload below:

```json
{
  "sort": {
    "column": "name",
    "direction": "desc"
  }
}
```

The `column` parameter can be persisted with the following line:

```ruby
preserve [:sort, :column]
```

### Default parameter value

There might be a situation where neither the parameters hash nor the session contains a parameter value.
To provide a fallback value for such a scenario, you can use the `default` option.
For instance:

```ruby
preserve :status, default: 'active'
```

Note that default values are not stored in the session, but assigned on every request instead.

### Blank parameter values

Normally, when a parameter value is an empty string it is overwritten by a value stored in the session.
To change this behavior, you can use the `allow_blank` option.

```ruby
preserve :status, allow_blank: true
```

As a result, the parameter value would be restored from the session only when the parameter was not sent in a request.
