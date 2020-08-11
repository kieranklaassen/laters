require_relative 'lib/run_later/version'

Gem::Specification.new do |spec|
  spec.name          = "run_later"
  spec.version       = RunLater::VERSION
  spec.authors       = ["Kieran Klaassen"]
  spec.email         = ["kieranklaassen@gmail.com"]

  spec.summary       = %q{Run any instance_method in ActiveRecord models via a job by adding `_later` to it.}
  spec.description   = %q{Deferrable empowers a class to run every single defined method wrapped in an ActiveJob of any class that includes it}
  spec.homepage      = "https://github.com/kieranklaassen/run_later"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/kieranklaassen/run_later"
  spec.metadata["changelog_uri"] = "https://github.com/kieranklaassen/run_later/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
