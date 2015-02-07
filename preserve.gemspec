$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'preserve/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'preserve'
  s.version     = Preserve::VERSION
  s.author      = 'Bartosz Pieńkowski'
  s.email       = 'pienkowb@gmail.com'
  s.homepage    = 'https://github.com/pienkowb/preserve'
  s.summary     = 'Persist parameter values between requests'
  s.description = 'Preserve is a Rails plugin which stores selected parameters in a session to make them available in subsequent requests.'

  s.files = Dir['{app,config,db,lib}/**/*'] + ['MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '~> 3.2.13'

  s.add_development_dependency 'sqlite3'
end
