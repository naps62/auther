$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'auther/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'auther'
  s.version     = Auther::VERSION
  s.authors     = ['Miguel Palhas']
  s.email       = ['mpalhas@gmail.com']
  s.homepage    = 'http://github.com/naps62/auther'
  s.summary     = 'An out-of-the-box authentication system based on Clearace and Omniauth'
  s.description = s.summary

  s.files = Dir['{app,config,db,lib}/**/*'] + ['MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['spec/**/*']

  s.add_dependency 'rails', '>= 3.0'
  s.add_dependency 'clearance', '1.0.0.rc8'
  s.add_dependency 'omniauth'

  s.add_development_dependency 'aruba'
  s.add_development_dependency 'bundler', '~> 1.3'
  s.add_development_dependency 'cucumber-rails', '~> 1.3'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails'
end
