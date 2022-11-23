Rails.application.routes.draw do

  namespace 'v0' do
    resources :orders, only: [:create]
  end
end
