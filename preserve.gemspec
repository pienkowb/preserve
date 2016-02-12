$:.push File.expand_path('../lib', __FILE__)

require 'preserve/version'

Gem::Specification.new do |s|
  s.name        = 'preserve'
  s.version     = Preserve::VERSION
  s.author      = 'Bartosz Pieńkowski'
  s.email       = 'pienkowb@gmail.com'
  s.homepage    = 'https://github.com/pienkowb/preserve'
  s.summary     = 'Persist parameter values between requests'
  s.description = 'Preserve is a Rails plugin which stores selected parameters in a session to make them available in subsequent requests.'
  s.license     = 'MIT'

  s.files = Dir['lib/**/*'] + %w(MIT-LICENSE Rakefile README.md)
  s.test_files = Dir['spec/**/*']

  s.required_ruby_version = '>= 1.9.3'

  s.add_dependency 'rails', '>= 3.0'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails'
end
