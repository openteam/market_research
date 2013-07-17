MarketResearch::Application.routes.draw do
  resources :mines do
    resources :configurations do
      get 'calc', :on => :member
      resources :configuration_segments, except: :index
    end

    resources :groupings do
      resources :grouping_parameters, :only => [:edit, :update]
      get 'grouping_segments', :on => :member
      get 'grouping_segments/:id', to: 'grouping_segments#show', as: 'segments'
      put 'rebuild', :on => :member
    end
  end

  root :to => 'mines#index'
end
