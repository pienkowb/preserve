ENV['RAILS_ENV'] ||= 'test'

require 'bundler/setup'
require 'coveralls'
require 'rails'

Coveralls.wear!

version = Rails::VERSION::MAJOR
dummy_root = File.expand_path("dummy/rails-#{version}", __dir__)

require "#{dummy_root}/config/environment.rb"
require 'rspec/rails'

Dir["#{__dir__}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.include RequestHelpers, type: :request
  config.include LegacyHelpers, type: :request if version < 5
end
