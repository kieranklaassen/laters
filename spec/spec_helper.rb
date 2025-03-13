require 'bundler/setup'
require 'logger'

# Define stub for ActiveSupport::LoggerThreadSafeLevel::Logger
module ActiveSupport
  module LoggerThreadSafeLevel
    class Logger < ::Logger; end
  end
end unless defined?(ActiveSupport::LoggerThreadSafeLevel::Logger)

require 'combustion'

# Initialize Rails test app
Combustion.initialize! :active_record, :active_job

# Setup test framework
require 'rspec/rails'
require 'laters'

# Configure ActiveJob for testing
ActiveJob::Base.queue_adapter = :test

require 'active_support/testing/time_helpers'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  # Include ActiveSupport::Testing::TimeHelpers for time manipulation
  config.include ActiveSupport::Testing::TimeHelpers

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
