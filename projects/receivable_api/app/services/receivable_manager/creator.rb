module ReceivableManager
  class Creator < ApplicationManager::Creator

    attr_reader :args, :receivable

    def initialize(args)
      @args = args
    end

    private

    def execute_creation
      @receivable = ::Receivable.create!(args)
    end

    def produce_rollback
      Karafka.producer.produce_sync(topic: 'rollback_receivable', payload: receivable.to_h.to_json)
    end
  end
end
