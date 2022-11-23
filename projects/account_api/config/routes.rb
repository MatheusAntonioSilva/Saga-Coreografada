Rails.application.routes.draw do

  namespace 'v0' do
    resources :accounts, only: [:create]
  end
end
