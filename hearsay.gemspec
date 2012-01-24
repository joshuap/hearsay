$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "hearsay/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "hearsay"
  s.version     = Hearsay::VERSION
  s.authors     = ["Joshua Wood"]
  s.email       = ["josh@joshuawood.net"]
  s.homepage    = "http://joshuawood.net/"
  s.summary     = "Models talking about models"
  s.description = "Hearsay is a plugin for Ruby On Rails that allows attributes of a model to loosely reference other models."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]
  s.require_paths = ["lib"]
  
  s.add_development_dependency("bundler", ["~> 1.0.0"])
  s.add_development_dependency("tomdoc")
  s.add_development_dependency("sqlite3")
end
