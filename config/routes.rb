MarketResearch::Application.routes.draw do
  resources :mines do
    resources :configurations do
      get 'calc', :on => :member
      resources :configuration_segments, except: :index
    end

    resources :groupings do
      resources :grouping_parameters, :only => [:edit, :update]
      put 'rebuild', :on => :member
      resources :grouping_segments, :only => [:index, :show]
    end
  end

  root :to => 'mines#index'
end
