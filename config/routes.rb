Rails.application.routes.draw do
  root to: 'requests#index'
  get 'find_request', to: 'requests#find'
  get 'admin', to: 'requests#admin'
  get 'admin/signin', to: 'requests#signin'
  post 'admin/login', to: 'requests#login'
  post 'admin/logout', to: 'requests#logout'
  put '/order/:name', to: 'requests#order', as: 'order'
  resources :requests, except: %i[edit destroy update] do
    resources :comments, except: %i[new show edit index]
  end
end
