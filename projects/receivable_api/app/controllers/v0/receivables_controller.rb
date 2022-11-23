class ::V0::ReceivablesController < ::V0::ApplicationController

  def create
    creator = ::ReceivableManager::Creator.new(payment_params)
    render json: creator.create, status: :created, serializer: ::V0::ReceivableSerializer::Model
  end

  private

  def payment_params
    params.permit(:description, :order_id)
  end
end
