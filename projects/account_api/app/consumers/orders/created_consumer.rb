module Orders
  class CreatedConsumer < ApplicationConsumer
    def consume
      messages.each { |message| puts message.payload }
    end
  end
end
