# Encoding: UTF-8
$:.push File.expand_path('../lib', __FILE__)
require 'refinery/midas/version'

version = Refinery::Midas::Version.to_s

Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'refinerycms-midas'
  s.version           =  version
  s.description       = 'Ruby on Rails Midas extension for Refinery CMS'
  s.date              = '2012-10-31'
  s.summary           = 'Midas extension for Refinery CMS'
  s.require_paths     = %w(lib)
  s.files             = Dir["{app,config,db,lib}/**/*"] + ["readme.md"]
  s.authors           = ['Second Bureau']

  # Runtime dependencies
  s.add_dependency             'refinerycms-core',    '~> 2.0.8'
  s.add_dependency             'haml'

  # Development dependencies (usually used for testing)
  s.add_development_dependency 'refinerycms-testing', '~> 2.0.8'
  s.add_development_dependency 'database_cleaner'
  
end
