module PaymentManager
  class Destroyer < ApplicationManager::Destroyer

    attr_reader :order_id

    def initialize(order_id)
      @order_id = order_id
    end

    def destroy
      ::Payment.where(order_id: order_id).destroy_all
    end
  end
end
