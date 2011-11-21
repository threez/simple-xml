# -*- encoding: utf-8 -*-
$:.push('lib')
require "simple_xml/version"

Gem::Specification.new do |s|
  s.name     = "simple-xml"
  s.version  = SimpleXML::VERSION.dup
  s.date     = "2011-11-21"
  s.summary  = "Some helpers for REXML::Element to create hashes from xml easily"
  s.email    = "vilandgr+simplexml@googlemail.com"
  s.homepage = "https://github.com/threez/simple-xml"
  s.authors  = ['Vincent Landgraf']
  
  s.description = "Some helpers for REXML::Element to create hashes from xml easily."
  
  dependencies = [
    [:development, "rspec", "~> 2.1"],
  ]
  
  s.files         = Dir['**/*']
  s.test_files    = Dir['test/**/*'] + Dir['spec/**/*']
  s.executables   = Dir['bin/*'].map { |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  ## Make sure you can build the gem on older versions of RubyGems too:
  s.rubygems_version = "1.8.10"
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.specification_version = 3 if s.respond_to? :specification_version
  
  dependencies.each do |type, name, version|
    if s.respond_to?("add_#{type}_dependency")
      s.send("add_#{type}_dependency", name, version)
    else
      s.add_dependency(name, version)
    end
  end
end
