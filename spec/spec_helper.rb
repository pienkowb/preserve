ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('dummy/config/environment.rb', __dir__)

require 'rspec/rails'

Rails.backtrace_cleaner.remove_silencers!

Dir["#{__dir__}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.color = true
  config.include RequestHelpers, type: :request
end
