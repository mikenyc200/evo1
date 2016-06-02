Rails.application.routes.draw do
#  resources :entities
#  resources :concepts
#  resources :keywords

  resources :feeds
  resources :entries
  root :to => 'entries#index'

  resources :feeds do
    member do
      get 'retrieve'
      post 'subscribe'
      post 'unsubscribe'
    end
  end

 mount SuperfeedrEngine::Engine => SuperfeedrEngine::Engine.base_path

end
