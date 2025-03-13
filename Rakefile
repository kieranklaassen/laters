require "bundler/gem_tasks"
require "rspec/core/rake_task"

# Silence the DidYouMean deprecation warnings 
if defined?(DidYouMean) && DidYouMean.respond_to?(:correct_error) && defined?(DidYouMean::SPELL_CHECKERS)
  # Monkey patch DidYouMean to suppress deprecation warnings
  DidYouMean::SPELL_CHECKERS.singleton_class.prepend(Module.new do
    def merge!(error_name, spell_checker)
      DidYouMean.correct_error(error_name, spell_checker)
    end
  end)
end

# Silence URI redefinition warnings in Ruby 3.2+
$VERBOSE = nil if RUBY_VERSION >= '3.2.0'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec
