# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kajomi/version'

Gem::Specification.new do |s|
  s.name          = "kajomi"
  s.version       = Kajomi::VERSION
  s.authors       = ["Dynport GmbH"]
  s.email         = ["manuel.boy@dynport.de"]
  s.description   = %q{Ruby gem for Kajomi mailer API}
  s.summary       = %q{Ruby gem for Kajomi mailer API}
  s.homepage      = "http://www.dynport.de"
  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]
  s.add_development_dependency "rspec"
  s.add_development_dependency "mail"
  s.add_development_dependency "vcr"
  s.add_development_dependency "webmock"
  s.add_development_dependency "active_support"
end
