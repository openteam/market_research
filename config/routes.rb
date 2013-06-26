MarketResearch::Application.routes.draw do
  resources :mines do
    resources :configurations do
      resources :segments
    end
  end

  root :to => 'mines#index'
end
