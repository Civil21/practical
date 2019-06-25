Rails.application.routes.draw do
  root to: 'requests#index'
  resources :requests, except: %i[edit destroy update]
  get 'find_request', to: 'requests#find'
end
