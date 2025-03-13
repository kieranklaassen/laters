# frozen_string_literal: true

module Laters
  # Main concern that provides asynchronous execution of ActiveRecord model methods
  #
  # This module adds the ability to defer execution of an instance method
  # to a background job by calling a method with the `_later` suffix.
  #
  # @example
  #   class User < ActiveRecord::Base
  #     include Laters::Concern
  #     
  #     def send_welcome_email
  #       # Some long running task
  #     end
  #   end
  #   
  #   # Basic usage (executes in background)
  #   user.send_welcome_email_later
  #
  #   # With scheduling options
  #   user.send_welcome_email_later(wait: 5.minutes)
  #   user.send_welcome_email_later(wait_until: 1.day.from_now)
  #
  module Concern
    extend ActiveSupport::Concern
    include ActiveModel::Callbacks

    # Define laters callbacks when concern is included
    included { define_model_callbacks :laters }

    class_methods do
      # @return [Symbol, nil] The queue name to use for background jobs
      attr_reader :job_queue

      private

      # Configure the queue to use for background jobs
      #
      # @param [Symbol] queue The queue name to use for jobs
      # @return [Symbol] The configured queue name
      # @example
      #   class Comment < ActiveRecord::Base
      #     include Laters::Concern
      #     run_in_queue :low
      #   end
      def run_in_queue(queue)
        @job_queue = queue
      end
    end

    private

    # Handles method calls with _later suffix by enqueueing background jobs
    #
    # @param [Symbol] method The method being called
    # @param [Array] args Arguments to pass to the method
    # @param [Hash] kwargs Keyword arguments to pass to the method
    #   Special kwargs for job scheduling are extracted:
    #   @option kwargs [Integer] :wait Time in seconds to wait before executing
    #   @option kwargs [Time] :wait_until Specific time to execute the job
    #   @option kwargs [Integer] :priority Priority for the job
    # @param [Proc] block Block to pass to the method (unused)
    # @return [ActiveJob::Base] The enqueued job
    # @raise [NoMethodError] If the method doesn't exist
    def method_missing(method, *args, **kwargs, &block)
      if (method_to_call = deferrable_method_name(method))
        # Extract ActiveJob options if they exist in kwargs
        job_options = { queue: self.class.job_queue || :default }
        
        # Move scheduling options from kwargs to job_options
        job_options[:wait] = kwargs.delete(:wait) if kwargs.key?(:wait)
        job_options[:wait_until] = kwargs.delete(:wait_until) if kwargs.key?(:wait_until)
        job_options[:priority] = kwargs.delete(:priority) if kwargs.key?(:priority)
        
        # Set all options at once
        InstanceMethodJob
          .set(job_options)
          .perform_later(self, method_to_call, *args, **kwargs)
      else
        super
      end
    end

    # Determines if the object responds to a method with _later suffix
    #
    # @param [Symbol] method_name The method name to check
    # @param [Boolean] include_private Whether to include private methods
    # @return [Boolean] True if the method can be handled
    def respond_to_missing?(method_name, include_private = false)
      method_name.to_s.ends_with?('_later') || super
    end

    # Extracts the actual method name from a method with _later suffix
    #
    # @param [Symbol] deferring_method Name of the deferring method that was called
    # @return [String, nil] The actual method name to call or nil if not applicable
    # @example
    #   deferrable_method_name(:send_email_later) # => "send_email"
    #   deferrable_method_name(:save_later) # => "save!" (if save! exists)
    def deferrable_method_name(deferring_method)
      return unless (method = deferring_method.to_s).ends_with? '_later'

      method.chomp! '_later'
      if respond_to? "#{method}!", true
        "#{method}!"
      elsif respond_to? method, true
        method
      end
    end
  end
end