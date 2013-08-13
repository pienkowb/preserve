$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "preserve/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "preserve"
  s.version     = Preserve::VERSION
  s.authors     = ["Bartosz Pieńkowski"]
  s.email       = ["pienkowb@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Preserve."
  s.description = "TODO: Description of Preserve."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.13"

  s.add_development_dependency "sqlite3"
end
