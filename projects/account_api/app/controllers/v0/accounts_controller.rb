class ::V0::AccountsController < ::V0::ApplicationController

  def create
    creator = ::AccountManager::Creator.new(account_params)
    render json: creator.create, status: :created, serializer: ::V0::AccountSerializer::Model
  end

  private

  def account_params
    params.permit(:name, :phone, :order_id)
  end
end
