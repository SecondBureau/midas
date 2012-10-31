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
        end
      end
      resources :accounts, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
