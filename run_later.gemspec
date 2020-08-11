require_relative 'lib/run_later/version'

Gem::Specification.new do |spec|
  spec.name          = "run_later"
  spec.version       = RunLater::VERSION
  spec.authors       = ["Kieran Klaassen", "Pelle ten Cate"]
  spec.email         = ["kieranklaassen@gmail.com"]

  spec.summary       = %q{Run any instance_method in ActiveRecord models via a job by adding `_later` to it.}
  spec.description   = %q{Deferrable empowers a class to run every single defined method wrapped in an ActiveJob of any class that includes it}
  spec.homepage      = "https://github.com/kieranklaassen/run_later"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/kieranklaassen/run_later"
  spec.metadata["changelog_uri"] = "https://github.com/kieranklaassen/run_later/blob/master/CHANGELOG.md"

  s.files = Dir[
    "app/**/*",
    "LICENSE.txt",
    "Rakefile",
    "README.md",
  ]
  s.add_dependency "rails", ">= 4.2"
end
