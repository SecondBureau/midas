Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :midas do
    resources :categories, :only => [:index, :show]
    resources :accounts, :only => [:index, :show]
    resources :entries, :only => [:index, :show]
  end

  # Admin routes
  namespace :midas, :path => '' do
    namespace :admin, :path => 'refinery/midas' do
      resources :categories, :except => :show do
        collection do
          post :update_positions
        end
      end
      resources :entries, :except => :show do
        collection do
          post :update_positions
          put :reconciliate
        end
      end
      resources :accounts, :except => :show do
        get :reconciliation
        collection do
          post :update_positions
        end
      end
      resources :salaries do
        collection do
          get :month_report
          post :update_event
        end
      end
      resources :employees, :except => :show do
      end
      resources :rates, :except => :show do
      end
    end
  end

end
