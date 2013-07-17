MarketResearch::Application.routes.draw do
  resources :mines do
    resources :configurations do
      get 'calc', :on => :member
      resources :segments, except: :index
    end

    resources :groupings do
      resources :grouping_parameters, :only => [:edit, :update]
      get 'segments', :on => :member
      get 'segments/:id', to: 'segments#show', as: 'segments'
      put 'rebuild', :on => :member
    end
  end

  root :to => 'mines#index'
end
