# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'misty/version'

Gem::Specification.new do |spec|
  spec.name          = "misty"
  spec.version       = Misty::VERSION
  spec.authors       = ["Gilles Dubreuil"]
  spec.email         = ["gilles@redhat.com"]

  spec.summary       = %q{Coming soon}
  spec.description   = %q{Misty is coming soon.}
  spec.homepage      = "https://github.com/flystack/misty"
  spec.license       = "GPL-3.0"

  all_files       = `git ls-files -z`.split("\x0")
  spec.files         = all_files.grep(%r{^(exe|lib|test)/|^.rubocop.yml$})
  spec.executables   = all_files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.bindir        = "exe"
  spec.require_paths = ['lib']

  spec.rdoc_options = ['--charset=UTF-8']
  spec.extra_rdoc_files = %w[README.md LICENSE.md]

  spec.add_development_dependency 'bundler', '~> 1.10'
end
