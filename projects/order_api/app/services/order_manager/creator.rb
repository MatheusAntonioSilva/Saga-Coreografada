module OrderManager
  class Creator < ApplicationManager::Creator

    attr_reader :args, :order

    def initialize(args)
      @args = args.with_indifferent_access
    end

    private

    def execute_creation
      @order = ::Order.create!(args)
      produce_event_created_order!
    end

    def produce_event_created_order!
      Karafka.producer.produce_sync(topic: 'created_order', payload: order.to_h.to_json)
    end

    def produce_rollback
      Karafka.producer.produce_sync(topic: 'rollback_order', payload: order.to_h.to_json)
    end
  end
end
