$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "discourse-import-vbulletin"
  s.version     = "0.0.1"
  s.authors     = ["Nikolay Zalutskiy", "Mikhail Sapozhnikov"]
  s.email       = ["pacemkr@gmail.com", "bulletblue@gmail.com"]
  s.summary     = "Adds rake tasks for importing a vBulletin database into Discourse."

  s.files = Dir["lib/**/*"]
end
