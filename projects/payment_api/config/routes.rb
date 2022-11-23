Rails.application.routes.draw do

  namespace 'v0' do
    resources :payments, only: [:create]
  end
end
