# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "em-socksify/version"

Gem::Specification.new do |s|
  s.name        = "em-socksify"
  s.version     = EventMachine::Socksify::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ilya Grigorik"]
  s.email       = ["ilya@igvita.com"]
  s.homepage    = "http://github.com/igrigorik/em-socksify"
  s.summary     = "EventMachine SOCKSify shim: adds SOCKS support to any protocol"
  s.description = s.summary

  s.rubyforge_project = "em-socksify"

  s.add_dependency "eventmachine"
  s.add_development_dependency "rspec"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
