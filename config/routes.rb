MarketResearch::Application.routes.draw do
  resources :mines do
    resources :configurations
  end
  root :to => 'mines#index'
end
