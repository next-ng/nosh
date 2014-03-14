# coding: utf-8
Gem::Specification.new do |spec|
  spec.name          = 'nosh'
  spec.version       = '0.0.1.unpublished'
  spec.authors       = 'next-ng'
  spec.email         = 'next-ng@example.com'
  spec.description   = 'Nosh is the best'
  spec.summary       = 'Nosh is the best'
  spec.homepage      = 'https://github.com/next-ng/nosh'
  spec.license       = 'Apache 2.0'

  spec.required_ruby_version = Gem::Requirement.new('>= 1.9.3')

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = %w[lib]

  spec.add_dependency 'thor'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
end
