module Receivables
  class RollbackConsumer < ApplicationConsumer
    def consume
      messages.each { |message| puts message.payload }
    end
  end
end
