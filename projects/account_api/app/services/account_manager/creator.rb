module AccountManager
  class Creator < ApplicationManager::Creator

    attr_reader :args, :account

    def initialize(args)
      @args = args
    end

    private

    def execute_creation
      @account = ::Account.create!(args)
    end

    def produce_rollback
      Karafka.producer.produce_sync(topic: 'rollback_account', payload: account.to_h.to_json)
    end
  end
end
