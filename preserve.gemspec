$LOAD_PATH.unshift(File.expand_path('lib', __dir__))

require 'preserve/version'

Gem::Specification.new do |spec|
  spec.name = 'preserve'
  spec.version = Preserve::VERSION
  spec.author = 'Bartosz Pieńkowski'
  spec.email = 'pienkowb@gmail.com'
  spec.homepage = 'https://github.com/pienkowb/preserve'
  spec.summary = 'Persist parameter values between requests'
  spec.description = 'Preserve is a Rails plugin which stores selected parameters in the session to make them available in subsequent requests.'
  spec.license = 'MIT'

  spec.files = Dir['lib/**/*'] + %w[MIT-LICENSE Rakefile README.md]
  spec.test_files = Dir['spec/**/*']

  spec.required_ruby_version = '>= 2.0.0'

  spec.add_dependency 'rails', '>= 3.0'

  spec.add_development_dependency 'appraisal', '~> 2.2'
  spec.add_development_dependency 'rspec-rails', '~> 3.9'
  spec.add_development_dependency 'rubocop', '~> 0.50.0'
  spec.add_development_dependency 'sqlite3', '~> 1.3.13'
end
