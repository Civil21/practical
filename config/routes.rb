Rails.application.routes.draw do
  root to: 'requests#index'
  resources :requests, except: %i[edit destroy update] do
    resources :comments, except: %i[new show edit index]
  end
  get 'find_request', to: 'requests#find'
  get 'admin', to: 'request#admin'
  get 'admin/login', to: 'request#login'
  get 'admin/logout', to: 'request#logout'
end
