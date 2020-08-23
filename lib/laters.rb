require 'laters/version'
require 'active_model'
require 'active_job'
require 'zeitwerk'
loader = Zeitwerk::Loader.for_gem
loader.push_dir('app/models/concerns')
loader.push_dir('app/jobs')
loader.setup

module Laters
  class Error < StandardError; end
end

loader.eager_load