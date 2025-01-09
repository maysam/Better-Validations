$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'better_validations/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = 'better_validations'
  spec.version     = BetterValidations::VERSION
  spec.authors     = ['Petr Bazov']
  spec.email       = ['petr@sequenia.com']
  spec.homepage    = 'http://sequenia.com/'
  spec.summary     = 'Extension for default Rails validations.'
  spec.description = 'Extension for default Rails validations. Adds some useful methods.'
  spec.license     = 'MIT'

  spec.files = Dir['{lib}/**/*', 'MIT-LICENSE', 'README.md']
  spec.require_paths = ['lib']

  spec.add_dependency 'rails', ['>= 5.0', '<= 7.2.2.1']
end
