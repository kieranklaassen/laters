# frozen_string_literal: true

module Laters
  # Job class that executes deferred instance methods with callbacks
  #
  # This job is responsible for executing a method on an ActiveRecord object
  # in the background. It runs all registered callbacks around the method execution.
  #
  # @example
  #   # This job is automatically used by the Laters::Concern
  #   InstanceMethodJob.perform_later(user, "send_welcome_email", arg1, arg2)
  #
  class InstanceMethodJob < (Rails.application.config.respond_to?(:active_job) ? 
                             Rails.application.config.active_job.base_job || ActiveJob::Base : 
                             ActiveJob::Base)
    # Executes the specified method on the given object
    #
    # @param [Object] object The object to call the method on
    # @param [String] method_name The name of the method to call
    # @param [Array] args Arguments to pass to the method
    # @param [Hash] kwargs Keyword arguments to pass to the method
    # @return [Object] The result of the method call
    # @raise [Exception] Any exception raised by the method
    def perform(object, method_name, *args, **kwargs)
      if object.respond_to? :id
        Rails.logger.info "Calling deferred #{method_name} on #{object.class} ##{object.id}"
      else
        Rails.logger.info "Calling deferred #{object.class}##{method_name}"
      end

      object.run_callbacks(:laters) { object.send(method_name, *args, **kwargs) }
    end
  end
end
