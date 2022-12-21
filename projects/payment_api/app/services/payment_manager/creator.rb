module PaymentManager
  class Creator < ApplicationManager::Creator

    attr_reader :args, :payment

    def initialize(args)
      @args = args
    end

    private

    def execute_creation
      @payment = ::Payment.create!(args)
    end

    def produce_rollback
      Karafka.producer.produce_sync(topic: 'rollback_payment', payload: payment.to_h.to_json)
    end
  end
end
