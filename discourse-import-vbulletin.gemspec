$:.push File.expand_path("../lib", __FILE__)

require "discourse_import_vbulletin"

Gem::Specification.new do |s|
  s.name        = "discourse-import-vbulletin"
  s.version     = DiscourseImportVbulletin::VERSION
  s.authors     = ["Nikolay Zalutskiy", "Mikhail Sapozhnikov"]
  s.email       = ["pacemkr@gmail.com", "bulletblue@gmail.com"]
  s.summary     = "Adds rake tasks for importing a vBulletin database into Discourse."

  s.files = Dir["lib/**/*"] + ["Rakefile"]
end
