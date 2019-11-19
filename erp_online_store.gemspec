$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "erp/online_store/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "erp_online_store"
  s.version     = Erp::OnlineStore::VERSION
  s.authors     = ["Nguyen Ngoc Son"]
  s.email       = ["sonnn@hoangkhang.com.vn"]
  s.homepage    = "http://timhangcongnghe.com/"
  s.summary     = "Frontend - Tim Hang Cong Nghe"
  s.description = "Frontend - Tim Hang Cong Nghe"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails"
  s.add_dependency "erp_core"
  s.add_dependency "deface"
  s.add_dependency "amazon-ecs"
  s.add_dependency "rebay"
  s.add_dependency "mechanize"
end
