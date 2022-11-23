class ::V0::PaymentsController < ::V0::ApplicationController

  def create
    creator = ::PaymentManager::Creator.new(payment_params)
    render json: creator.create, status: :created, serializer: ::V0::PaymentSerializer::Model
  end

  private

  def payment_params
    params.permit(:description, :order_id)
  end
end
