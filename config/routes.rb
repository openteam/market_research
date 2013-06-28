MarketResearch::Application.routes.draw do
  resources :mines do
    resources :configurations do
      get 'calc', :on => :member
      resources :segments
    end

    resources :groupings do
      get 'data', :on => :member
    end
  end

  root :to => 'mines#index'
end
