Spina::Engine.routes.draw do
  resources :articles

  namespace :admin do
    resources :articles
  end
end
