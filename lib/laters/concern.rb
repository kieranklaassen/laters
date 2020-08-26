# frozen_string_literal: true

module Laters
  module Concern
    extend ActiveSupport::Concern
    include ActiveModel::Callbacks

    included { define_model_callbacks :laters }

    class_methods do
      attr_reader :job_queue

      private

      def run_in_queue(queue)
        @job_queue = queue
      end
    end

    private

    def method_missing(method, *args, &block)
      if (method_to_call = deferrable_method_name(method))
        InstanceMethodJob
          .set(queue: self.class.job_queue || :default)
          .perform_later(self, method_to_call, *args)
      else
        super
      end
    end

    def respond_to_missing?(method_name, include_private = false)
      method_name.to_s.ends_with?('_later') || super
    end

    # @param [Symbol] deferring_method Name of the deferring method that was called
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