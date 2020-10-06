# frozen_string_literal: true

require_relative './lib/database_cleaner/nobrainer/version'

Gem::Specification.new do |spec|
  spec.name          = 'database_cleaner-nobrainer'
  spec.version       = DatabaseCleaner::Nobrainer::VERSION
  spec.authors       = ['Guillaume Hain']
  spec.email         = ['zedtux@zedroot.org']

  spec.summary       = 'Strategies for cleaning databases using Nobrainer.'
  spec.description   = 'Strategies for cleaning databases using Nobrainer. ' \
                       'Can be used to ensure a clean state for testing.'
  spec.homepage      = 'https://github.com/zedtux/database_cleaner-nobrainer'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'database_cleaner-core', '~>2.0.0.beta2'
  spec.add_dependency 'nobrainer', '~> 0.30'

  spec.add_development_dependency 'appraisal', '~> 2'
  spec.add_development_dependency 'bundler', '~> 2'
  spec.add_development_dependency 'rake', '~> 13'
  spec.add_development_dependency 'rspec', '~> 3'
end
