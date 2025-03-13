# frozen_string_literal: true

module Laters
  class InstanceMethodJob < (Rails.application.config.respond_to?(:active_job) ? 
                             Rails.application.config.active_job.base_job || ActiveJob::Base : 
                             ActiveJob::Base)
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
