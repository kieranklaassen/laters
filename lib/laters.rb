require 'laters/version'

require 'active_support'
require 'active_model'
require 'active_job'
require 'laters/concern'
require 'laters/instance_method_job'

module Laters
  class Error < StandardError; end
end
