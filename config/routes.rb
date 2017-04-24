Rails.application.routes.draw do
  resources :budgets

  get 'signup' => 'user#new'
  post 'signup' => 'user#create'

  get 'profile' => 'user#edit'
  patch 'profile' => 'user#update'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  scope 'budget/:budget_id' do
    resources :accounts
    resources :periods
    resources :lines do
      post :bulk, :on => :collection
    end
    resources :recurring_lines
    get 'setup' => 'setup#edit', :as => 'setup'
    post 'setup' => 'setup#update'
    get '', :to => 'grid#index', :as => 'grid'
  end

  root :to => 'budgets#index'
end
