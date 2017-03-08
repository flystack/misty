# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'misty/version'

Gem::Specification.new do |spec|
  spec.name          = "misty"
  spec.version       = Misty::VERSION
  spec.authors       = ["Gilles Dubreuil"]
  spec.email         = ["gilles@redhat.com"]

  spec.summary       = %q{Misty is a dedicated HTTP client for OpenStack providing dynamic APIs requests management.}
  spec.description   = %q{Misty is a dedicated HTTP client for OpenStack providing dynamic APIs requests management.}
  spec.homepage      = "https://github.com/flystack/misty"
  spec.license       = "GPL-3.0"

  all_files          = `git ls-files -z`.split("\x0")
  spec.files         = all_files.grep(%r{^(exe|lib|test)/|^.rubocop.yml$})
  spec.executables   = all_files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.bindir        = "exe"
  spec.require_paths = ['lib']

  spec.rdoc_options = ['--charset=UTF-8']
  spec.extra_rdoc_files = %w[README.md LICENSE.md]

  spec.add_dependency 'json', '~> 2.0'

  spec.add_development_dependency 'bundler',    '~> 1.10'
  spec.add_development_dependency 'rake',       '~> 10.0'
  spec.add_development_dependency 'minitest',   '~> 5.10'
  spec.add_development_dependency 'webmock',    '~> 1.24'
  spec.add_development_dependency 'vcr',        '~> 3.0'
  spec.add_development_dependency 'pry-byebug', '~> 3.4'
end
