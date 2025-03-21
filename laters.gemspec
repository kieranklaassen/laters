require_relative 'lib/laters/version'

Gem::Specification.new do |spec|
  spec.name          = 'laters'
  spec.version       = Laters::VERSION
  spec.authors       = ['Kieran Klaassen', 'Pelle ten Cate']
  spec.email         = ['kieranklaassen@gmail.com']

  spec.summary       = 'Run any instance_method in ActiveRecord models via a job by adding `_later` to it.'
  spec.description   = 'Deferrable empowers a class to run every single defined method wrapped in an ActiveJob of any class that includes it'
  spec.homepage      = 'https://github.com/kieranklaassen/laters'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 3.0.0', '< 3.5')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/kieranklaassen/laters'
  spec.metadata['changelog_uri'] = 'https://github.com/kieranklaassen/laters/blob/master/CHANGELOG.md'

  spec.files = Dir['Rakefile', '*.{md,txt}', '{app,lib}/**/*']

  spec.add_dependency 'rails', '>= 5.0', '< 9'
  spec.add_dependency 'thor', '>= 1.2.0' # Use newer thor version to fix DidYouMean deprecation
end
