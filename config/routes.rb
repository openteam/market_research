MarketResearch::Application.routes.draw do
  resources :mines do
    resources :configurations do
      get 'calc', :on => :member
      resources :segments
    end

    resources :groupings
  end

  root :to => 'mines#index'
end
