module Sentry
  parent_job =
    if defined?(ApplicationJob)
      ApplicationJob
    else
      ActiveJob::Base
    end

  class SendEventJob < parent_job
    discard_on ActiveJob::DeserializationError # this will prevent infinite loop when there's an issue deserializing SentryJob

    def perform(event)
      Sentry.send_event(event)
    end
  end
end

