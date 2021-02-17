# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name = 'fake_gem__'
  s.version = '0.0.0'
  s.authors = ['Paul Morgan']
  s.summary = 'pre-commit hooks for ruby projects'
  s.description = 'pre-commit hooks for ruby projects'
  s.add_dependency 'bigdecimal' # needed by reek
  s.add_dependency 'bundler-audit'
  s.add_dependency 'fasterer', '0.8.3'
  s.add_dependency 'mdl', '0.9.0'
  s.add_dependency 'rake' # needed by reek
  s.add_dependency 'reek', '6.0.3'
  s.add_dependency 'rubocop', '1.10.0'
  s.add_dependency 'rubocop-performance', '1.6.1'
  s.add_dependency 'rubocop-rspec', '1.40.0'
  s.bindir = 'pre_commit_hooks'
  s.executables = [
    'run-bundle-audit',
    'run-fasterer',
    'run-mdl',
    'run-reek',
    'run-rubocop',
  ]
  s.required_ruby_version = '>= 2.5'
end
