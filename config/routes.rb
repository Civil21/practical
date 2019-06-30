Rails.application.routes.draw do
  root to: 'requests#index'
  get 'find_request', to: 'requests#find'
  get 'admin', to: 'requests#admin'
  get 'admin/signin', to: 'requests#signin'
  post 'admin/login', to: 'requests#login'
  post 'admin/logout', to: 'requests#logout'
  put '/order/:name', to: 'requests#order', as: 'order'
  get '/help', to: 'requests#help', as: 'help'
  post 'help', to: 'requests#feed'

  resources :requests, except: %i[edit destroy update] do
    member do
      post '/stat/:name', to: 'requests#stat', as: 'stat'
    end
    resources :comments, except: %i[new show edit index]
  end
end
