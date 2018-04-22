Gem::Specification.new do |s|
  s.name = '__fake_gem'
  s.version = '0.0.0'
  s.authors = ['Paul Morgan']
  s.summary = 'pre-commit hooks for ruby projects'
  s.description = 'pre-commit hooks for ruby projects'
  s.add_dependency 'fasterer', '0.4.1'
  s.bindir = 'pre_commit_hooks'
  s.executables = ['run-fasterer']
end
