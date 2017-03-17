$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "oh_sheet/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "oh_sheet"
  s.version     = OhSheet::VERSION
  s.authors     = ["Jaimerson Araújo"]
  s.email       = ["jaimersonaraujo@gmail.com"]
  s.homepage    = "https://github.com/jaimerson/oh_sheet"
  s.summary     = "Imports xlsx files into database"
  s.description = "Mountable engine to add bulk importing functionality"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 4.0"
  s.add_dependency "paperclip", "~> 5.0"
  s.add_dependency "creek", "~> 1.1.2"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails", "~> 3.5"
  s.add_development_dependency "pry"
end
