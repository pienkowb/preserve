$:.push File.expand_path('../lib', __FILE__)

require 'preserve/version'

Gem::Specification.new do |spec|
  spec.name = 'preserve'
  spec.version = Preserve::VERSION
  spec.author = 'Bartosz Pieńkowski'
  spec.email = 'pienkowb@gmail.com'
  spec.homepage = 'https://github.com/pienkowb/preserve'
  spec.summary = 'Persist parameter values between requests'
  spec.description = 'Preserve is a Rails plugin which stores selected parameters in a session to make them available in subsequent requests.'
  spec.license = 'MIT'

  spec.files = Dir['lib/**/*'] + %w(MIT-LICENSE Rakefile README.md)
  spec.test_files = Dir['spec/**/*']

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_dependency 'rails', '>= 3.0'

  spec.add_development_dependency 'sqlite3', '~> 1.3.13'
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'appraisal'
end
