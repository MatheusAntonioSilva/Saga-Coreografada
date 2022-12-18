# frozen_string_literal: true

class KarafkaApp < Karafka::App
  setup do |config|
    config.kafka = { 'bootstrap.servers': Rails.application.config.app.kafka.seed_brokers.join(',') }
    config.client_id = Rails.application.config.app.kafka.client_id
    # Recreate consumers with each batch. This will allow Rails code reload to work in the
    # development mode. Otherwise Karafka process would not be aware of code changes

    config.concurrency = Rails.application.config.app.kafka.concurrency
    config.shutdown_timeout = Rails.application.config.app.kafka.shutdown_timeout

    config.consumer_persistence = !Rails.env.development?
  end

  # Comment out this part if you are not using instrumentation and/or you are not
  # interested in logging events for certain environments. Since instrumentation
  # notifications add extra boilerplate, if you want to achieve max performance,
  # listen to only what you really need for given environment.
  Karafka.monitor.subscribe(Karafka::Instrumentation::LoggerListener.new)
  # Karafka.monitor.subscribe(Karafka::Instrumentation::ProctitleListener.new)

  routes.draw do
    # Uncomment this if you use Karafka with ActiveJob
    # You ned to define the topic per each queue name you use
    # active_job_topic :default

    consumer_group :rollback_account_group_1 do
      topic :rollback_account do
        consumer ::Accounts::RollbackConsumer

        dead_letter_queue(topic: :rollback_account_dlt, max_retries: Rails.application.config.app.kafka.max_retries)
      end
    end
  end
end
